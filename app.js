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

        const query = 'INSERT INTO user_backend (name, password) VALUES (?, ?)';
        connection.query(query, [username, hash], (err, results) => {
            if (err) {
                console.error('Error inserting user:', err);
                return;
            }
            console.log('User created successfully:', results);
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

app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.post('/login', (req, res) => {
    const { name, password } = req.body;
    const query = 'SELECT id, name, password FROM user_backend WHERE name = ?';

    connection.query(query, [name], (err, results) => {
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
                    console.log(`Login successful: ${name} (ID: ${user.id})`);
                    // Log successful login
                    connection.query('INSERT INTO login_logs (user_id, status) VALUES (?, ?)', [user.id, 'success'], (err, results) => {
                        if (err) {
                            console.error('Error logging login attempt:', err);
                        }
                    });
                    res.redirect('/backend');
                } else {
                    console.log(`Login failed: Invalid password for user ${name}`);
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
            console.log(`Login failed: User ${name} not found`);
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

app.get('/logout', (req, res) => {
    console.log(`User logged out: ${req.session.userId}`);
    req.session.destroy();
    res.redirect('/login');
});

app.use('/backend', isAuthenticated);

// Set up view engine and paths
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Routes for backend views
app.get('/backend/editRoom', (req, res) => {
    res.render('editRoom');
});

app.get('/backend/addBook', (req, res) => {
    res.render('Add');
});

app.get('/backend/bestSelling', (req, res) => {
    res.render('bestSelling');
});

app.get('/backend/edit', (req, res) => {
    res.render('edit');
});

app.get('/backend/editBook/:id', (req, res) => {
    res.render('editBook', { id: req.params.id });
});

app.get('/backend/newsBooks', (req, res) => {
    res.render('newsBooks');
});

app.get('/backend/success', (req, res) => {
    res.render('success');
});

app.get('/backend/cancel', (req, res) => {
    res.render('cancel');
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
