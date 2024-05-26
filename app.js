// app.js
const express = require('express');
const debug = require('debug')('app');
const morgan = require('morgan');
const path = require("path");

const app = express();
const port = process.env.port || 5000;
const productrouter = require("./src/router/productrouter");

app.use(morgan('combined'));

app.use('/books', productrouter);
// app.use('/books/:productTitle', productrouter);

app.use(express.static(path.join(__dirname, "./public/")))
app.set("views", "./src/views");
app.set("view engine", "ejs");

app.get('/books/:title', (req, res) => {
    (req.params.title);
    // Now use the decoded title to fetch the corresponding book or render the page
    // Example:
    res.render('booksDetail');
});


app.listen(port, async () => {
    const chalk = await import('chalk');
    debug("Listening on port" + chalk.default.green(port));
});


module.exports = productrouter;