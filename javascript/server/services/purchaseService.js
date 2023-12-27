import db from "../config/db.js";
import { Response } from "../models/response.js";

const getByUser = `SELECT * from purchase where id_user = ?`;

export class PurchaseService {
    getPurchaseByUser(request) {
        return new Promise((resolve, reject) => {
            let params = [request.id_user];
            db.all(getByUser, params, (err, row) => {
                if (err) {
                    let message = `Coudln't find purchases. Unexpected error.`;
                    console.log(message);
                    reject(new Response(undefined, 500, message));
                    return;
                }

                let purchases = row;
                if (purchases === undefined || purchases === "") {
                    let message = `Couldn't find purchases of user with id = ${request.id_user}`;
                    console.log(message);
                    reject(new Response(undefined, 404, message));
                    return;
                }

                resolve(new Response(purchases, 200, undefined));
            });
        });
    }

    makeOrder(request) {
        return new Promise((resolve, reject) => {
            db.run("BEGIN TRANSACTION", (beginErr) => {
                if (beginErr) {
                    reject(
                        new Error(
                            `Error beginning transaction: ${beginErr.message}`
                        )
                    );
                    return;
                }

                const sql = `INSERT INTO purchase (id_product, id_user, price, quantity, purchase_date, delivery_type, payment_type) VALUES (?, ?, ?, ?, ?, ?, ?)`;

                const stmt = db.prepare(sql);

                try {
                    request.forEach((row) => {
                        stmt.run(row.id_product, row.id_user, row.price, row.quantity, row.purchase_date, row.delivery_type, row.payment_type, (runErr) => {
                            if (runErr) {
                                console.error(
                                    "Error inserting row:",
                                    runErr.message
                                );
                            }
                        });
                    });
                } catch (error) {
                    console.log(error.message);
                }

                stmt.finalize();

                db.run("COMMIT", (commitErr) => {
                    if (commitErr) {
                        reject(
                            new Error(
                                `Error committing transaction: ${commitErr.message}`
                            )
                        );
                    } else {
                        resolve("Bulk insert successful.");
                    }
                });
            });
        });
    }
}
