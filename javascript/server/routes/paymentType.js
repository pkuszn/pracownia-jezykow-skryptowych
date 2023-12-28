import paymentType from "../controllers/paymentTypeController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(paymentType.getPaymentTypes);

router.route('/:id')
    .get(paymentType.getPaymentType);

export default router;