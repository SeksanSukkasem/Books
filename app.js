const express = require('express');
const debug = require('debug')('app');
const morgan = require('morgan');
const path = require("path");
const mysql = require("mysql");
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// Serve static files from the src/image directory
app.use('/uploads', express.static(path.join(__dirname, 'src', 'image')));

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

app.listen(port, async () => {
    const chalk = await import('chalk');
    debug("Listening on port " + chalk.default.green(port));
});

module.exports = app;
