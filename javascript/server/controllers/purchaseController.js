import expressAsyncHandler from "express-async-handler";
import db from "../config/db.js";
import { PurchaseService } from "../services/purchaseService.js";
import { UserService } from "../services/userService.js";

const purchaseService = new PurchaseService();
const userService = new UserService();

const getPurchase = expressAsyncHandler(async (req, res) => {
    let params = [req.params.id];
    let sql = `SELECT * from purchase where id = ?`;

    db.all(sql, params, (err, row) => {
        if (err) {
            return res.status(400).json({ error: err.message });
        }

        res.status(200).json(row);
    });
});

const getPurchases = expressAsyncHandler(async (req, res) => {
    let sql = `SELECT * from purchase`;

    db.all(sql, [], (err, row) => {
        if (err) {
            return res.status(400).json({ error: err.message });
        }

        return res.status(200).json(row);
    });
});

const postPurchase = expressAsyncHandler(async (req, res) => {
    let sql = `INSERT INTO purchase (id_product, id_user, price, quantity, purchase_date, delivery_type, payment_type) VALUES (?, ?, ?, ?, ?, ?, ?)`;
    let params = [
        req.body.id_product,
        req.body.id_user,
        req.body.price,
        req.body.quantity,
        req.body.purchase_date,
        req.body.delivery_type,
        req.body.payment_type,
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        return res.json({ message: "Data inserted successfully" });
    });
});

const putPurchase = expressAsyncHandler(async (req, res) => {
    let sql = `UPDATE purchase SET id_product = ?, id_user = ?, price = ?, quantity = ?, purchase_date = ?, delivery_type = ?, payment_type = ? WHERE id = ?;`;
    let params = [
        req.body.id_product,
        req.body.id_user,
        req.body.price,
        req.body.quantity,
        req.body.purchase_date,
        req.body.delivery_type,
        req.body.payment_type,
        req.params.id,
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        return res.status(200).json({ message: "Data updated successfully" });
    });
});

const deletePurchase = expressAsyncHandler(async (req, res) => {
    let sql = `DELETE from purchase WHERE id = ?`;
    let params = [req.params.id];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        return res.status(200).json({ message: "Data deleted successfully" });
    });
});

const getPurchaseByName = expressAsyncHandler(async (req, res) => {
    let userRequest = {
        name: req.body.name,
    };

    userService
        .getUserByName(userRequest)
        .then((response) => {
            let user = response.data;
            let purchaseRequest = {
                id_user: user.id,
            };

            purchaseService
                .getPurchaseByUser(purchaseRequest)
                .then((response) => {
                    return res.status(response.status).json(response.data);
                })
                .catch((err) => {
                    return res.status(err.status).json({ error: err.message });
                });
        })
        .catch((err) => {
            return res.status(err.status).json({ error: err.message });
        });
});

const makeOrder = expressAsyncHandler(async (req, res) => {
    let request = req.body;
    purchaseService
        .makeOrder(request)
        .then((response) => {
            return res.status(200).json("Ok")
        })
        .catch((err) => {
            return res.status(err.status).json({
                error: err.message,
            });
        });
});

export default {
    getPurchase,
    getPurchases,
    postPurchase,
    putPurchase,
    deletePurchase,
    getPurchaseByName,
    makeOrder,
};
