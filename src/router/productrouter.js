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

// productRouters.get('/', (req, res) => {
//     const sql = 'SELECT productTitle, productDescription FROM products';
//     connection.query(sql, (err, data) => {
//         if (err) {
//             debug(err);
//             return res.json('Error');
//         }
//         res.render('home', {
//             dataBooks: data
//         });
//     });
// });


// Route to get all product books from MySQL database and display in "/books"
productRouters.get('/', (req, res) => {
    const sql = 'SELECT id, productTitle, productDescription FROM products';
    connection.query(sql, (err, data) => {
        if (err) {
            debug(err);
            return res.json('Error');
        }
        res.render('product', {
            product: data
        });
    });
});


// Route to render addBook page
productRouters.get('/addBook', (req, res) => {
    res.render('Add');
});

// Route to handle addBook form submission
productRouters.post('/addBook', (req, res) => {
    const { productTitle, productDescription, productPrice } = req.body;

    if (!productTitle || !productDescription || !productPrice) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    const query = 'INSERT INTO products (productTitle, productDescription, productPrice) VALUES (?, ?, ?)';
    connection.query(query, [productTitle, productDescription, productPrice], (err, results) => {
        if (err) {
            console.error('Error inserting book into database:', err);
            return res.status(500).json({ error: 'Error inserting book into database' });
        }
        res.redirect('/books'); // Redirect to the books list page after successful insertion
    });
});

// Route to get book details by ID
productRouters.get('/books/:productTitle', (req, res) => {
    const bookId = req.params.productTitle;
    const query = 'SELECT * FROM products WHERE productTitle = ?';
    connection.query(query, [bookId], (err, result) => {
        if (err) {
            console.error('Error fetching book details:', err);
            return res.status(500).json({ error: 'Error fetching book details' });
        }
        if (result.length === 0) {
            return res.status(404).json({ error: 'Book not found' });
        }
        res.render('booksDetail', { dataBooks: result });
    });
});

module.exports = productRouters;
