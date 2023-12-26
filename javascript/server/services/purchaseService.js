import db from "../config/db.js";
import { Response } from "../models/response.js";

const getByUser = `SELECT * from purchase where id_user = ?`;

export class PurchaseService {
    getPurchaseByUser(request) {
        let params = [request.id_user];
        db.all(getByUser, params, (err, row) => {
            if (err) {
                let message = `Coudln't find purchases. Unexpected error.`;
                return new Response(undefined, 500, message);
            }

            let purchases = row;
            if (purchases === undefined || purchases === "") {
                let message = `Couldn't find purchases of user with id = ${request.id_user}`;
                console.log(message);
                return new Response(undefined, 404, message);
            }

            return new Response(purchases, 200, undefined);
        });
    }

    makeOrder(request) {
        const sql = `INSERT INTO purchase (id_product, id_user, price, quantity, purhcase_date, delivery_type, payment_type) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        db.serialize(() => {
            const stmt = db.prepare(sql);
            request.forEach(row => stmt.run(row));
            stmt.finalize();
            db.run('COMMIT', err => {
                var message;
                var response;
                if (err) {
                    message = 'Error committing transaction'
                    console.error(message, err.message);
                    response =  new Response(undefined, 500, message); 
                } else {
                    message = "Bulk insert successful.";
                    console.log(message);
                    response = new Response(true, 200, message);
                }
                db.close();
                return response;
            });
        });
    }
}