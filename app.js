// app.js
const express = require('express');
const debug = require('debug')('app');
const morgan = require('morgan');
const path = require("path");
const mysql = require("mysql");
const multer = require('multer');

const app = express();
app.use(express.json());

// Set up multer storage for handling file uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/'); // Specify the destination folder for storing uploads
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname); // Rename the file with a unique name
    }
});

const upload = multer({ storage: storage });

// Handle file upload route
app.post('/upload', upload.single('file'), (req, res) => {
    // Access uploaded file information using req.file
    console.log(req.file);
    res.send('File uploaded successfully!');
});


const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'node_sql'
});

connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the MySQL server.');
});


const port = process.env.PORT || 5000;
const productrouter = require("./src/router/productrouter");
const { type } = require('os');

app.use(morgan('combined'));
app.use('/', productrouter);
app.use('/books', productrouter);
app.use('/addBook', productrouter);


app.use(express.static(path.join(__dirname, "./public/")));
app.set("views", "./src/views");
app.set("view engine", "ejs");

app.get('/books/:title', (req, res) => {
    const title = req.params.title;
    // Now use the decoded title to fetch the corresponding book or render the page
    // Example:
    res.render('booksDetail', { title });
});

app.listen(port, async () => {
    const chalk = await import('chalk');
    debug("Listening on port " + chalk.default.green(port));
});

module.exports = app;
