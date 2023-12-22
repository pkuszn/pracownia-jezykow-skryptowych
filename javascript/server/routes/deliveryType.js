import deliveryType from "../controllers/deliveryTypeController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(deliveryType.getDeliveryTypes);

router.route('/:id')
    .get(deliveryType.getDeliveryType);

export default router;