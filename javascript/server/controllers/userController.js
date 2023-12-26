import expressAsyncHandler from "express-async-handler";    
import db from "../config/db.js";
import { UserService } from "../services/userService.js";

const userService = new UserService();

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
        req.body.password,
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
        req.body.password,
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

const checkUser = expressAsyncHandler(async(req, res) => {
    let request = {
        name: req.body.name,
        password: req.body.password
    };

    let response = userService.checkUser(request);
    
    if (response.status !== 200) {
        return res.status(response.status).json("Couldn't find user.", response.message);
    }

    return res.status(response.status).json(response.data);
});

const getUserByName = expressAsyncHandler(async(req, res) => {
    let request = {
        name: req.body.name
    };

    let response = userService.getUserByName(request);

    if (response.status !== 200) {
        return res.status(response.status).json("Couldn't find user.", response.message);
    }

    return res.status(response.status).json(response.data);
})

export default {
    getUser,
    getUsers,
    postUser,
    putUser,
    deleteUser,
    checkUser,
    getUserByName
};