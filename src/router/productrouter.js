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

let cart = [];  // Ensure cart array is initialized

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
productRouters.get('/backend/addBook', (req, res) => {
    res.render('../backend/Add');
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

// Route to render editRoom page
productRouters.get('/backend/editRoom', (req, res) => {
    const sql = 'SELECT id, productTitle, productDescription, productPrice, image FROM products';
    connection.query(sql, (err, data) => {
        if (err) {
            return res.json('Error');
        }
        res.render('../backend/editRoom', { product: data });
    });
});

// Route to render edit book page
productRouters.get('/backend/editBook/:productTitle', (req, res) => {
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
        res.render('../backend/edit', { book: result[0] });
    });
});

// Route to handle edit book form submission
productRouters.post('/backend/edit/:id', upload.single('image'), (req, res) => {
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
        res.redirect('../backend/editRoom'); // Redirect to the editRoom page after successful update
    });
});

// Route to handle delete book form submission
productRouters.post('/deleteBook/:id', (req, res) => {
    const bookId = req.params.id;
    const query = 'DELETE FROM products WHERE id = ?';

    connection.query(query, [bookId], (err, result) => {
        if (err) {
            console.error('Error deleting book:', err);
            return res.status(500).json({ error: 'Error deleting book' });
        }
        res.redirect('/backend/editRoom'); // Redirect to the editRoom page after successful deletion
    });
});

// Route to add product to cart
productRouters.post('/addToCart', (req, res) => {
    const { id, productTitle, productPrice } = req.body;
    const product = { id, productTitle, productPrice, quantity: 1 };

    const existingProduct = cart.find(item => item.id === id);
    if (existingProduct) {
        existingProduct.quantity += 1;
    } else {
        cart.push(product);
    }

    res.json({ message: 'Product added to cart', cart });
});

// Route to display cart
productRouters.get('/market', (req, res) => {
    let total = 0;
    let shippingCost = 50; // Example fixed shipping cost
    cart.forEach(item => {
        total += item.productPrice * item.quantity;
    });
    let netTotal = total + shippingCost;

    res.render('market', { cart, total, shippingCost, netTotal });
});


module.exports = productRouters;
