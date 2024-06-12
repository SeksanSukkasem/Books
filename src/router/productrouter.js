const express = require('express');
const mysql = require('mysql');
const multer = require('multer');
const path = require('path');
const promptPay = require('promptpay-qr');
const qrcode = require('qrcode');
const { error } = require('console');

const productRouters = express.Router();

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
    const productQuery = 'SELECT id, productTitle, author, productType, productPrice, image, category FROM products';
    const bestSellingQuery = 'SELECT id, productTitle, author, productType, productPrice, image, category FROM products WHERE bestSelling = 1';
    const newBooksQuery = 'SELECT id, image FROM newbook';
    const categoryQuery = 'SELECT DISTINCT category FROM products';

    connection.query(productQuery, (err, productData) => {
        if (err) {
            console.error('Error fetching products:', err);
            return res.status(500).send('Error fetching products');
        }

        connection.query(bestSellingQuery, (err, bestSellingData) => {
            if (err) {
                console.error('Error fetching best selling books:', err);
                return res.status(500).send('Error fetching best selling books');
            }

            connection.query(newBooksQuery, (err, newBooksData) => {
                if (err) {
                    console.error('Error fetching new books:', err);
                    return res.status(500).send('Error fetching new books');
                }

                connection.query(categoryQuery, (err, categoryData) => {
                    if (err) {
                        console.error('Error fetching categories:', err);
                        return res.status(500).send('Error fetching categories');
                    }
                    res.render('product', {
                        product: productData,
                        bestSelling: bestSellingData,
                        newBooks: newBooksData,
                        categories: categoryData
                    });
                });
            });
        });
    });
});




// Route to render addBook page
productRouters.get('/backend/addBook', (req, res) => {
    res.render('../backend/Add');
});

// Route to handle addBook form submission
productRouters.post('/addBook', upload.single('image'), (req, res) => {
    const { productTitle, productDescription, author, publisher, category, pages, productType, size, weight, barcode, productPrice } = req.body;
    const image = req.file ? `/uploads/${req.file.filename}` : null;

    if (!productTitle || !productDescription || !author || !publisher || !category || !pages || !productType || !size || !weight || !barcode || !productPrice || !image) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    const query = 'INSERT INTO products (productTitle, productDescription, author, publisher, category, pages, productType, size, weight, barcode, productPrice, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    connection.query(query, [productTitle, productDescription, author, publisher, category, pages, productType, size, weight, barcode, productPrice, image], (err, results) => {
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

// Route to render backend navigation page
productRouters.get('/backend', (req, res) => {
    const sql = 'SELECT id, productTitle, productDescription, productPrice, image FROM products';
    connection.query(sql, (err, data) => {
        if (err) {
            return res.json('Error');
        }
        res.render('../backend/backend', { product: data });
    });
});


productRouters.get('/bestSelling', (req, res) => {
    const query = 'SELECT * FROM products WHERE isBestSelling = TRUE';

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching best selling books:', err);
            return res.status(500).json({ error: 'Error fetching best selling books' });
        }
        res.render('bestSelling', { books: results });
    });
});

productRouters.post('/addBestSelling', (req, res) => {
    const { productId } = req.body;
    const query = 'UPDATE products SET isBestSelling = TRUE WHERE id = ?';

    connection.query(query, [productId], (err, results) => {
        if (err) {
            console.error('Error marking book as best selling:', err);
            return res.status(500).json({ error: 'Error marking book as best selling' });
        }
        res.json({ message: 'Book marked as best selling successfully!' });
    });
});


// Route to fetch new books from the newBook table
productRouters.get('/newBooks', (req, res) => {
    const query = 'SELECT * FROM newBook';

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching new books:', err);
            return res.status(500).json({ error: 'Error fetching new books' });
        }
        res.render('../backend/newBooks', { books: results });
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
        res.redirect('../backend/editRoom'); // Redirect to the editRoom page after successful deletion
    });
});

productRouters.post('/addToCart', (req, res) => {
    const { product_id, product_title, product_price } = req.body;

    if (!product_id || !product_title || !product_price) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    const query = 'INSERT INTO market (product_id, product_title, product_price, quantity) VALUES (?, ?, ?, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1';
    connection.query(query, [product_id, product_title, product_price], (err, results) => {
        if (err) {
            console.error('Error adding to cart:', err);
            return res.status(500).json({ error: 'Error adding to cart' });
        }
        
        // Get the total count of items in the cart
        const countQuery = 'SELECT SUM(quantity) as totalQuantity FROM market';
        connection.query(countQuery, (err, countResult) => {
            if (err) {
                console.error('Error fetching cart count:', err);
                return res.status(500).json({ error: 'Error fetching cart count' });
            }
            const totalQuantity = countResult[0].totalQuantity || 0;
            res.json({ message: 'Product added to cart successfully!', totalQuantity });
        });
    });
});

productRouters.get('/market/count', (req, res) => {
    const query = 'SELECT SUM(quantity) as totalQuantity FROM market';
    connection.query(query, (err, countResult) => {
        if (err) {
            console.error('Error fetching cart count:', err);
            return res.status(500).json({ error: 'Error fetching cart count' });
        }
        const totalQuantity = countResult[0].totalQuantity || 0;
        res.json({ totalQuantity });
    });
});

// // Route to handle addToCart form submission
// productRouters.post('/addToCart', (req, res) => {
//     const { product_id, product_title, product_price } = req.body;

//     if (!product_id || !product_title || !product_price) {
//         return res.status(400).json({ error: 'All fields are required' });
//     }
    
//     const query = 'INSERT INTO market (product_id, product_title, product_price, quantity) VALUES (?, ?, ?, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1';
//     connection.query(query, [product_id, product_title, product_price], (err, results) => {
//         if (err) {
//             console.error('Error adding to cart:', err);
//             return res.status(500).json({ error: 'Error adding to cart' });
//         }
//         res.json({ message: 'Product added to cart successfully!' });
//     });
   
// });


// Route to render market page
productRouters.get('/market', (req, res) => {
    const query = 'SELECT id, product_title, product_price, quantity FROM market';
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching market data:', err);
            return res.status(500).json({ error: 'Error fetching market data' });
        }
        res.render('../views/market', { cart: results });
    });
});
// Route to handle generating a QR code
productRouters.post('/generate-qr', async (req, res) => {
    const { totalPrice } = req.body;

    // Use PromptPay format for QR code generation
    const promptPayID = '1111111111111'; // PromptPay ID หรือ เบอร์โทรศัพท์
    const promptPayData = `00020101021129370016A0000006770101110113006601250${totalPrice}5802TH0000${promptPayID}6304`;

    try {
        const qrCodeUrl = await qrcode.toDataURL(promptPayData);
        res.json({ qrCodeUrl });
    } catch (err) {
        console.error('Error generating QR code:', err);
        res.status(500).json({ error: 'Error generating QR code' });
    }
});
// Route to handle deleting a product from the market
productRouters.post('/market/delete/:id', (req, res) => {
    const bookId = req.params.id;
    const query = 'DELETE FROM market WHERE id = ?';

    connection.query(query, [bookId], (err, result) => {
        if (err) {
            console.error('Error deleting book:', err);
            return res.status(500).json({ error: 'Error deleting book' });
        }
        res.redirect('/market'); // Redirect to the market page after successful deletion
    });
});


productRouters.post('/backend/bestSelling', upload.single('image'), (req, res) => {
    const image = req.file ? `/uploads/${req.file.filename}` : null;

    if (!image) {
        return res.status(400).json({ error: 'Image is required' });
    }

    const query = 'INSERT INTO newBook (image) VALUES (?)';
    connection.query(query, [image], (err, results) => {
        if (err) {
            console.error('Error inserting image into database:', err);
            return res.status(500).json({ error: 'Error inserting image into database' });
        }
        res.json({ message: 'Image added successfully!' });
    });
});



productRouters.get('/backend/newsBooks', (req, res) => {
    res.render('../backend/newsBooks');
});

productRouters.post('/backend/newsBooks', upload.single('image'), (req, res) => {
    const image = req.file ? `/uploads/${req.file.filename}` : null;

    if (!image) {
        return res.status(400).json({ error: 'Image is required' });
    }

    const query = 'INSERT INTO newBook (image) VALUES (?)';
    connection.query(query, [image], (err, results) => {
        if (err) {
            console.error('Error inserting image into database:', err);
            return res.status(500).json({ error: 'Error inserting image into database' });
        }
        res.json({ message: 'Image added successfully!' });
    });
});


module.exports = productRouters;
