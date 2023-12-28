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

router.route('/check')
    .post(user.checkUser);

router.route('/name')
    .post(user.getUserByName);

export default router;

    