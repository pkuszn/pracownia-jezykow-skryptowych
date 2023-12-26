import purchase from "../controllers/purchaseController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(purchase.getPurchases)
    .post(purchase.postPurchase);

router.route('/:id')
    .get(purchase.getPurchase)
    .put(purchase.putPurchase)
    .delete(purchase.deletePurchase);

router.route('/user')
    .post(purchase.getPurchaseByName);

router.route('/order')
    .post(purchase.makeOrder)

export default router;

    