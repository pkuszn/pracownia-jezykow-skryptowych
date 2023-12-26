import expressAsyncHandler from "express-async-handler";    
import db from '../config/db.js';
import { PurchaseService } from "../services/purchaseService.js";
import { UserService } from "../services/userService.js";
import { purchase } from "../models/purchase.js";

const purchaseService = new PurchaseService();
const userService = new UserService();

const getPurchase = expressAsyncHandler(async(req, res) => {
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

const getPurchases = expressAsyncHandler(async(req, res) => {
    let sql = `SELECT * from purchase`;

    db.all(sql, [], (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        res.status(200).json(row);
    })
});

const postPurchase = expressAsyncHandler(async(req, res) => {
    let sql = `INSERT INTO purchase (id_product, id_user, price, quantity, purchase_date, delivery_type) VALUES (?, ?, ?, ?, ?, ?)`;
    let params = [
        req.body.id_product,
        req.body.id_user,
        req.body.price,
        req.body.quantity,
        req.body.purchaseDate,
        req.body.deliveryType,
        req.body.paymentType,
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        res.json({"message": "Data inserted successfully"});
    })
});

const putPurchase = expressAsyncHandler(async(req, res) => {
    let sql = `UPDATE purchase SET id_product = ?, id_user = ?, price = ?, quantity = ?, purchase_date = ?, delivery_type = ? WHERE id = ?;`
    let params = [
        req.body.id_product,
        req.body.id_user,
        req.body.price,
        req.body.quantity,
        req.body.purchaseDate,
        req.body.deliveryType,
        req.body.paymentType,
        req.params.id
    ];

    db.run(sql, params, (err) => {
        if (err) {
            return res.status(500).json({"error": err.message});
        }

        res.status(200).json({"message": "Data updated successfully"});
    })
});

const deletePurchase = expressAsyncHandler(async(req, res) => {
    let sql = `DELETE from purchase WHERE id = ?`
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

const getPurchaseByName = expressAsyncHandler(async(req, res) => {
    let userRequest = {
        "name": req.params.name
    };

    let userResponse = userService.getUserByName(userRequest);
    
    if (userResponse.status !== 200) {
        res.status(userResponse.status).json({"error": userResponse.message});
        return;
    }

    let user = userResponse.data;

    let purchaseRequest = {
        "id_user": user.id 
    };

    let purchaseResponse = purchaseService.getPurchaseByUser(purchaseRequest);
    
    if (purchaseResponse.status !== 200) {
        res.status(purchaseResponse.status).json({"error": purchaseResponse.message});
        return;
    }

    return res.status(purchaseResponse.status).json(purchaseResponse.data);
})

const makeOrder = expressAsyncHandler(async(req, res) => {
    let orderResponse = purchaseService.makeOrder(request);
    
    if (orderResponse.status !== 200) {
        res.status(orderResponse.status).json({"error": orderResponse.message});
    } else {
        res.status(orderResponse.status).json(orderResponse.data);
    }
})

export default {
    getPurchase,
    getPurchases,
    postPurchase,
    putPurchase,
    deletePurchase,
    getPurchaseByName,
    makeOrder
};