import db from "../config/db.js";
import { Response } from "../models/response.js";

const getByNameConst = `SELECT * from user where name = ?`;

export class UserService {

    checkUser(request) {
        let params = [request.name];
        db.all(getByNameConst, params, (err, row) => {
            if (err) {
                let message = `Coudln't find user. Unexpected error.`;
                return new Response(undefined, 500, message);
            }

            let user = row;
            if (user === undefined || user === "") {
                let message = `Couldn't find user with name = ${request.name}`;
                console.log(message);
                return new Response(undefined, 404, message);
            }

            if (user.password !== request.password) {
                let message = `Couldn't find user with provided password`;
                console.log(message);
                return new Response(undefined, 404, message);
            }

            return new Response(user, 200, undefined);
        });
    }

    getUserByName(request) {
        let params = [request.name];
        db.all(getByNameConst, params, (err, row) => {
            if (err) {
                let message = `Couldn't find user. Unexpected error.`;
                return new Response(undefined, 500, message);
            }

            let user = row;

            return new Response(user, 200, undefined);
        })
    }
}
