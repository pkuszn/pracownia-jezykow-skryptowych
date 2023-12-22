import category from "../controllers/categoryController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(category.getCategories);

router.route('/:id')
    .get(category.getCategory);

export default router;