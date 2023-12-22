import expressAsyncHandler from "express-async-handler";    
import db from "../config/db.js";

const getUser = expressAsyncHandler(async(req, res) => {
    let params = [req.params.id];
    let sql = `SELECT * from user where id = ?`;

    db.all(sql, params, (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        res.status(200).json(row);
    })
});

const getUsers = expressAsyncHandler(async(req, res) => {
    let sql = `SELECT * from user`;

    db.all(sql, [], (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        res.status(200).json(row);
    })
});

const postUser = expressAsyncHandler(async(req, res) => {
    let sql = `INSERT INTO user (name, surname, address, created_date) VALUES (?, ?, ?, ?);`
    let params = [
        req.body.name,
        req.body.surname,
        req.body.address,
        req.body.createdDate,
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        res.status(200).json({"message": "Data inserted successfully"});
    })
});

const putUser = expressAsyncHandler(async(req, res) => {
    let sql = `UPDATE user SET name = ?, surname = ?, address = ?, created_date = ? WHERE id = ?;`
    let params = [
        req.body.name,
        req.body.surname,
        req.body.address,
        req.body.createdDate,
        req.params.id
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        res.status(200).json({"message": "Data updated successfully"});
    })
});

const deleteUser = expressAsyncHandler(async(req, res) => {
    let sql = `DELETE from user WHERE id = ?`
    let params = [
        req.params.id
    ]

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        res.status(200).json({"message": "Data deleted successfully"});
    })
});

export default {
    getUser,
    getUsers,
    postUser,
    putUser,
    deleteUser
};