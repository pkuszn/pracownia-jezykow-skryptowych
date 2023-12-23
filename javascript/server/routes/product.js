import product from "../controllers/productController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(product.getProducts)
    .post(product.postProduct);

router.route('/:id')
    .get(product.getProduct)
    .put(product.putProduct)
    .delete(product.deleteProduct);

router.route('/category/:id')
    .get(product.getProductsByCategory);

export default router;