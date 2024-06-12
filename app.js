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

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/uploads', express.static(path.join(__dirname, 'src', 'image')));
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// // Create MySQL connection
// const connection = mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'node_sql'
// });

// // Connect to MySQL
// connection.connect((err) => {
//     if (err) {
//         console.error('Error connecting to the database:', err);
//         return;
//     }
//     console.log('Connected to the MySQL server.');
// });

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

app.get('/books/:title', (req, res) => {
    const title = req.params.title;
    res.render('booksDetail', { title });
});
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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
