import user from "../controllers/userController.js";
import express from "express";

const router = express.Router();

router.route('/')
    .get(user.getUsers)
    .post(user.postUser);

router.route('/:id')
    .get(user.getUser)
    .put(user.putUser)
    .delete(user.deleteUser);

export default router;

    