const express = require('express');
const debug = require('debug')('app');
const morgan = require('morgan');
const path = require("path");
const mysql = require("mysql");

const app = express();
app.use(express.json());

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

    // Function to add a book
    function addBook() {
        const bookData = {
            title: 'Book Title',
            description: 'Book Description',
            price: 10.99
        };

        const query = 'INSERT INTO products SET ?';
        connection.query(query, bookData, (err, result) => {
            if (err) {
                console.error('Error adding book:', err);
                return;
            }
            console.log('Book added successfully!');
        });
    }

    // Call the function to add a book
    addBook();
});

const port = process.env.PORT || 5000;
const productrouter = require("./src/router/productrouter");

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
