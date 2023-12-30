import expressAsyncHandler from "express-async-handler";    
import db from "../config/db.js";

const getProduct = expressAsyncHandler(async(req, res) => {
    let params = [req.params.id];
    let sql = `SELECT * from product where id = ?`;

    db.all(sql, params, (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        return res.status(200).json(row);
    })
});

const getProducts = expressAsyncHandler(async(req, res) => {
    let sql = `SELECT * from product`;

    db.all(sql, [], (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        return res.status(200).json(row);
    })
});

const getProductsByCategory = expressAsyncHandler(async(req, res) => {
    let sql = `SELECT * FROM product where category = ?`;
    let params = [req.params.id];
    db.all(sql, params, (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        return res.status(200).json(row);
    });
})

const postProduct = expressAsyncHandler(async(req, res) => {
    let sql = `INSERT INTO product (name, category, price, created_date, description, available) VALUES (?, ?, ?, ?, ?, ?);`
    let params = [
        req.body.name,
        req.body.category,
        req.body.price,
        req.body.created_date,
        req.body.description,
        req.body.available
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        return res.json({"message": "Data inserted successfully"});
    })
});

const putProduct = expressAsyncHandler(async(req, res) => {
    let sql = `UPDATE product SET name = ?, category = ?, price = ?, created_date = ?, description = ?, available = ? WHERE id = ?;`
    let params = [
        req.body.name,
        req.body.category,
        req.body.price,
        req.body.created_date,
        req.body.description,
        req.body.available,
        req.params.id
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        return res.status(200).json({"message": "Data updated successfully"});
    })
});

const deleteProduct = expressAsyncHandler(async(req, res) => {
    let sql = `DELETE from product WHERE id = ?`
    let params = [
        req.params.id
    ]

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        return res.status(200).json({"message": "Data deleted successfully"});
    })
});

export default {
    getProduct,
    getProducts,
    postProduct,
    putProduct,
    deleteProduct,
    getProductsByCategory
};