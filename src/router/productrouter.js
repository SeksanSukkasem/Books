const express = require('express');
const mysql = require('mysql');
const debug = require('debug')('app');
const productRouters = express.Router();
const dataBooks = require('../data/dataBooks.json');


productRouters.get("/", (req, res) => {
    res.render("booksDetail", {
        dataBooks
    });
});

// // Route to get all product books from MySQL database
// productRouters.get("/productbooks", (req, res) => {
//     const sql = "SELECT * FROM productbooks";
//     con.query(sql, (err, data) => {
//         if (err) {
//             debug(err);
//             return res.json("Error");
//         }
//         return res.json(data);
//     });
// });

module.exports = productRouters;
