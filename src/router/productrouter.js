const express = require('express');
const mysql = require('mysql');
const debug = require('debug')('app');
const productRouters = express.Router();

// Create MySQL connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'node_sql'
});

// Route to get all product books from MySQL database and display only title and description in "/"
productRouters.get("/", (req, res) => {
    const sql = "SELECT productTitle, productDescription FROM products"; // Assuming your table name is 'products'
    connection.query(sql, (err, data) => {
        if (err) {
            debug(err);
            return res.json("Error");
        }
        res.render("product", {
            product: data // Pass the fetched data to the template
        });
    });
});

// Route to get all product books from MySQL database and display all columns in "/books"
productRouters.get("/books", (req, res) => {
    const sql = "SELECT * FROM products"; // Assuming your table name is 'products'
    connection.query(sql, (err, data) => {
        if (err) {
            debug(err);
            return res.json("Error");
        }
        res.render("booksDetail", {
            dataBooks: data // Pass the fetched data to the template
        });
    });
});

productRouters.get('/addBook', (req, res) => {
    
    res.render("Add");
});



productRouters.post('/addBook', (req, res) => {
    const { productTitle, productDescription, productPrice, imageUrl } = req.body;

    const query = "INSERT INTO products (productTitle, productDescription, productPrice, imageUrl) VALUES (?, ?, ?, ?)";

    connection.query(query, [productTitle, productDescription, productPrice, imageUrl], (err, data) => {
        if (err) {
            debug(err);
            return res.status(500).json({ error: "Error adding book" });
        }
        // Assuming you have an "addBook.ejs" template
        res.render("Add", {
            data: data // Pass the fetched data to the template
        });
    });
});

module.exports = productRouters;
