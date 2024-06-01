const express = require('express');
const mysql = require('mysql');
const multer = require('multer');
const path = require('path');
const productRouters = express.Router();

// Create MySQL connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'node_sql'
});

// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'src/image/');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

// Route to get all product books from MySQL database and display in "/books"
productRouters.get('/', (req, res) => {
    const sql = 'SELECT id, productTitle, productDescription, productPrice, image FROM products';
    connection.query(sql, (err, data) => {
        if (err) {
            return res.json('Error');
        }
        res.render('product', { product: data });
    });
});

// Route to render addBook page
productRouters.get('/addBook', (req, res) => {
    res.render('Add');
});

// Route to handle addBook form submission
productRouters.post('/addBook', upload.single('image'), (req, res) => {
    const { productTitle, productDescription, productPrice } = req.body;
    const image = req.file ? `/uploads/${req.file.filename}` : null;

    if (!productTitle || !productDescription || !productPrice || !image) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    const query = 'INSERT INTO products (productTitle, productDescription, productPrice, image) VALUES (?, ?, ?, ?)';
    connection.query(query, [productTitle, productDescription, productPrice, image], (err, results) => {
        if (err) {
            console.error('Error inserting book into database:', err);
            return res.status(500).json({ error: 'Error inserting book into database' });
        }
        res.json({ message: 'Book added successfully!' });
    });
});

// Route to get book details by productTitle
productRouters.get('/books/:productTitle', (req, res) => {
    const bookTitle = req.params.productTitle;
    const query = 'SELECT * FROM products WHERE productTitle = ?';
    connection.query(query, [bookTitle], (err, result) => {
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

// Route to render edit book page
productRouters.get('/editBook/:productTitle', (req, res) => {
    const bookTitle = req.params.productTitle;
    const query = 'SELECT * FROM products WHERE productTitle = ?';
    connection.query(query, [bookTitle], (err, result) => {
        if (err) {
            console.error('Error fetching book for edit:', err);
            return res.status(500).json({ error: 'Error fetching book for edit' });
        }
        if (result.length === 0) {
            return res.status(404).json({ error: 'Book not found' });
        }
        res.render('editBook', { book: result[0] });
    });
});

// Route to handle edit book form submission
productRouters.post('/editBook/:id', upload.single('image'), (req, res) => {
    const bookId = req.params.id;
    const { productTitle, productDescription, productPrice } = req.body;
    const image = req.file ? `/uploads/${req.file.filename}` : null;

    const query = image 
        ? 'UPDATE products SET productTitle = ?, productDescription = ?, productPrice = ?, image = ? WHERE id = ?' 
        : 'UPDATE products SET productTitle = ?, productDescription = ?, productPrice = ? WHERE id = ?';
    const queryParams = image 
        ? [productTitle, productDescription, productPrice, image, bookId]
        : [productTitle, productDescription, productPrice, bookId];

    connection.query(query, queryParams, (err, result) => {
        if (err) {
            console.error('Error updating book:', err);
            return res.status(500).json({ error: 'Error updating book' });
        }
        res.redirect('/books'); // Redirect to the books list page after successful update
    });
});

module.exports = productRouters;
