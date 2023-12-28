import expressAsyncHandler from "express-async-handler";    
import db from "../config/db.js";

const getCategory = expressAsyncHandler(async(req, res) => {
    let params = [req.params.id];
    let sql = `select * from category where id = ?`;
    
    db.get(sql, params, (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        return res.status(200).json(row);
    })
});

const getCategories = expressAsyncHandler(async(req, res) => {
    let sql = `select * from category`;

    db.all(sql, [], (err, row) => {
        if (err) {
            res.status(400).json({"error": err.message});
            return;
        }

        return res.status(200).json(row);
    })
});

export default {
    getCategory,
    getCategories
};