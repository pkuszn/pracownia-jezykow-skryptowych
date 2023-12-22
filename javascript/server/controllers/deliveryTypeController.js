import expressAsyncHandler from "express-async-handler";    
import db from "../config/db.js";

const getDeliveryType = expressAsyncHandler(async(req, res) => {
    let params = [req.params.id];
    let sql = `SELECT * from delivery_type where id = ?`;

    db.get(sql, params, (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        res.status(200).json(row);
    })

});

const getDeliveryTypes = expressAsyncHandler(async(req, res) => {
    let sql = `SELECT * from delivery_type`;

    db.all(sql, [], (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        res.status(200).json(row);
    })
});

export default {
    getDeliveryType,
    getDeliveryTypes,
};