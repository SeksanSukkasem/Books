const express = require('express');
const debug = require('debug')('app');
const morgan = require('morgan');
const path = require("path");
const app = express();
const QRCode = require('qrcode');
const generatePayload = require('promptpay-qr');
const bodyParser = require('body-parser');
const cors = require('cors');
const _ = require('lodash');
const session = require('express-session');
const bcrypt = require('bcrypt');
const mysql = require('mysql');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

// Create MySQL connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'node_sql'
});

// Connect to MySQL
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the MySQL server.');

    const username = 'admin';
    const password = '12345';
    const saltRounds = 10;

    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (err) {
            console.error('Error hashing password:', err);
            return;
        }

        const query = 'INSERT IGNORE INTO users (username, password, isAdmin) VALUES (?, ?, ?)';
        connection.query(query, [username, hash, true], (err, results) => {
            if (err) {
                console.error('Error inserting admin user:', err);
                return;
            }
            console.log('Admin user created successfully:', results);
        });
    });
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/uploads', express.static(path.join(__dirname, 'src', 'image')));
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Use 'secure: true' in production with HTTPS
}));

// Nodemailer transporter setup
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'seksan@gmail.com',
        pass: '1234567890'
    }
});

app.get('/register', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'register.html'));
});

app.get('/forgot-password', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'forgotPassword.html'));
});

// Authentication middleware
function isAuthenticated(req, res, next) {
    if (req.session.userId) {
        console.log(`User authenticated: ${req.session.userId}`);
        return next();
    } else {
        console.log('User not authenticated. Redirecting to login.');
        res.redirect('/login');
    }
}

function isAdmin(req, res, next) {
    if (req.session.isAdmin) {
        return next();
    } else {
        res.redirect('/login');
    }
}

app.post('/register', (req, res) => {
    const { username, password, email } = req.body;
    const saltRounds = 10;

    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (err) {
            console.error('Error hashing password:', err);
            return res.status(500).json({ success: false, message: 'Internal server error' });
        }

        const query = 'INSERT INTO user_backend (name, password, email) VALUES (?, ?, ?)';
        connection.query(query, [username, hash, email], (err, results) => {
            if (err) {
                console.error('Error inserting user:', err);
                return res.status(500).json({ success: false, message: 'Internal server error' });
            }
            res.status(200).json({ success: true, message: 'User registered successfully' });
        });
    });
});

app.post('/forgot-password', (req, res) => {
    const { email } = req.body;
    const token = crypto.randomBytes(20).toString('hex');

    const query = 'UPDATE user_backend SET resetPasswordToken = ?, resetPasswordExpires = ? WHERE email = ?';
    const resetPasswordExpires = Date.now() + 3600000; // 1 hour
    connection.query(query, [token, resetPasswordExpires, email], (err, results) => {
        if (err) {
            console.error('Error setting reset token:', err);
            return res.status(500).json({ success: false, message: 'Internal server error' });
        }

        const mailOptions = {
            to: email,
            from: 'your-email@gmail.com',
            subject: 'Password Reset',
            text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n
                   Please click on the following link, or paste this into your browser to complete the process:\n\n
                   http://${req.headers.host}/reset/${token}\n\n
                   If you did not request this, please ignore this email and your password will remain unchanged.\n`
        };

        transporter.sendMail(mailOptions, (err) => {
            if (err) {
                console.error('Error sending email:', err);
                return res.status(500).json({ success: false, message: 'Internal server error' });
            }
            res.status(200).json({ success: true, message: 'Password reset link has been sent to your email.' });
        });
    });
});

app.get('/reset/:token', (req, res) => {
    const { token } = req.params;
    const query = 'SELECT * FROM user_backend WHERE resetPasswordToken = ? AND resetPasswordExpires > ?';
    connection.query(query, [token, Date.now()], (err, results) => {
        if (err || results.length === 0) {
            console.error('Password reset token is invalid or has expired');
            return res.status(400).json({ success: false, message: 'Password reset token is invalid or has expired' });
        }
        res.sendFile(path.join(__dirname, 'public', 'resetPassword.html'));
    });
});

app.post('/reset/:token', (req, res) => {
    const { token } = req.params;
    const { password } = req.body;
    const saltRounds = 10;

    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (err) {
            console.error('Error hashing password:', err);
            return res.status(500).json({ success: false, message: 'Internal server error' });
        }

        const query = 'UPDATE user_backend SET password = ?, resetPasswordToken = NULL, resetPasswordExpires = NULL WHERE resetPasswordToken = ?';
        connection.query(query, [hash, token], (err, results) => {
            if (err) {
                console.error('Error resetting password:', err);
                return res.status(500).json({ success: false, message: 'Internal server error' });
            }
            res.status(200).json({ success: true, message: 'Password reset successfully' });
        });
    });
});

app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'userLogin.html'));
});

app.get('/admin/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'adminLogin.html'));
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT id, name, password FROM user_backend WHERE name = ?';

    connection.query(query, [username], (err, results) => {
        if (err) {
            console.error('Error fetching user:', err);
            return res.status(500).send('Internal server error');
        }
        if (results.length > 0) {
            const user = results[0];
            bcrypt.compare(password, user.password, (err, isMatch) => {
                if (err) {
                    console.error('Error comparing passwords:', err);
                    return res.status(500).send('Internal server error');
                }
                if (isMatch) {
                    req.session.userId = user.id;
                    console.log(`Login successful: ${username} (ID: ${user.id})`);
                    // Log successful login
                    connection.query('INSERT INTO login_logs (user_id, status) VALUES (?, ?)', [user.id, 'success'], (err, results) => {
                        if (err) {
                            console.error('Error logging login attempt:', err);
                        }
                    });
                    res.redirect('/user/home');
                } else {
                    console.log(`Login failed: Invalid password for user ${username}`);
                    // Log failed login
                    connection.query('INSERT INTO login_logs (user_id, status) VALUES (?, ?)', [user.id, 'failed'], (err, results) => {
                        if (err) {
                            console.error('Error logging login attempt:', err);
                        }
                    });
                    res.status(401).send('Invalid username or password');
                }
            });
        } else {
            console.log(`Login failed: User ${username} not found`);
            // Log failed login attempt without user ID
            connection.query('INSERT INTO login_logs (user_id, status) VALUES (?, ?)', [null, 'failed'], (err, results) => {
                if (err) {
                    console.error('Error logging login attempt:', err);
                }
            });
            res.status(401).send('Invalid username or password');
        }
    });
});

app.post('/admin/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT id, username, password FROM users WHERE username = ?';

    connection.query(query, [username], (err, results) => {
        if (err) {
            console.error('Error fetching admin:', err);
            return res.status(500).send('Internal server error');
        }
        if (results.length > 0) {
            const admin = results[0];
            bcrypt.compare(password, admin.password, (err, isMatch) => {
                if (err) {
                    console.error('Error comparing passwords:', err);
                    return res.status(500).send('Internal server error');
                }
                if (isMatch) {
                    req.session.userId = admin.id;
                    req.session.isAdmin = true; // Mark session as admin
                    res.json({ success: true });
                } else {
                    res.json({ success: false, message: 'Invalid username or password.' });
                }
            });
        } else {
            res.json({ success: false, message: 'Invalid username or password.' });
        }
    });
});


app.get('/logout', (req, res) => {
    console.log(`User logged out: ${req.session.userId}`);
    req.session.destroy();
    res.redirect('/');
});

app.use('/backend', isAuthenticated, isAdmin, (req, res, next) => {
    next();
});

// Set up view engine and paths
app.set('views', path.join(__dirname, 'src', 'views'));
app.set('view engine', 'ejs');

// Routes for backend views
app.get('../backend/editRoom', (req, res) => {
    res.render('editRoom');
});

app.get('../backend/addBook', (req, res) => {
    res.render('Add');
});

app.get('../backend/bestSelling', (req, res) => {
    res.render('bestSelling');
});

app.get('../backend/edit', (req, res) => {
    res.render('edit');
});

app.get('../backend/editBook/:id', (req, res) => {
    res.render('editBook', { id: req.params.id });
});

app.get('../backend/newsBooks', (req, res) => {
    res.render('newsBooks');
});

app.get('../backend/success', (req, res) => {
    res.render('success');
});

app.get('../backend/cancel', (req, res) => {
    res.render('cancel');
});

app.get('../user/home', isAuthenticated, (req, res) => {
    res.render('userHome', { userId: req.session.userId });
});

const port = process.env.PORT || 3000;
const productrouter = require("./src/router/productrouter");

app.use(morgan('combined'));
app.use('/', productrouter);
app.use('/addBook', productrouter);

app.use(express.static(path.join(__dirname, "./public/")));
app.set("views", path.join(__dirname, "src/views"));
app.set("views", "./src/views");
app.set("backend", "./src/backend");
app.set("view engine", "ejs");
const productRouter = require('./src/router/productrouter');
app.use('/', productRouter);
app.use('/addBook', productRouter);

app.get('/books/:title', (req, res) => {
    const title = req.params.title;
    res.render('booksDetail', { title });
});

app.post('/generateQR', (req, res) => {
    const amount = parseFloat(_.get(req, ["body", "amount"]));
    const mobileNumber = '0123456789'; // เปลี่ยนเป็นเบอร์โทรของคุณ
    const payload = generatePayload(mobileNumber, { amount });
    const option = {
        color: {
            dark: '#000', // สีของ QR code
            light: '#fff' // สีพื้นหลัง
        }
    };
    QRCode.toDataURL(payload, option, (err, url) => {
        if (err) {
            console.log('Failed to generate QR code', err);
            return res.status(400).json({
                RespCode: 400,
                RespMessage: 'Error: ' + err
            });
        } else {
            return res.status(200).json({
                RespCode: 200,
                RespMessage: 'Success',
                Result: url
            });
        }
    });
});

app.listen(port, async () => {
    const chalk = await import('chalk');
    debug("Listening on port " + chalk.default.green(port));
});

module.exports = app;
