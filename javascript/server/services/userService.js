import db from "../config/db.js";
import { Response } from "../models/response.js";

const getByNameConst = `SELECT * from user where name = ?`;
const passwordConst = "password";

export class UserService {
    checkUser(request) {
        return new Promise((resolve, reject) => {
          let params = [request.name];      
          db.all(getByNameConst, params, (err, row) => {
            if (err) {
              let message = `Couldn't find user. Unexpected error.`;
              reject(new Response(undefined, 500, message));
              return;
            }
      
            let user = row[0];
            if (!user) {
              let message = `Couldn't find user with name = ${request.name}`;
              console.log(message);
              reject(new Response(undefined, 404, message));
              return;
            }
      
            if (user[passwordConst] !== request.password) {
              let message = `Couldn't accept user with the provided password`;
              console.log(message);
              reject(new Response(undefined, 404, message));
              return;
            }
      
            resolve(new Response(user, 200, ""));
          });
        });
      }

    getUserByName(request) {
        return new Promise((resolve, reject) => {
            let params = [request.name];
            db.all(getByNameConst, params, (err, row) => {
                if (err) {
                    let message = `Couldn't find user. Unexpected error.`;
                    console.log(message);
                    reject(new Response(undefined, 500, message));
                    return
                }
    
                let user = row[0];
                resolve(new Response(user, 200, undefined));
            });
        });
    }
}
