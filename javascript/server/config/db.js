import sqlite3 from 'sqlite3';
import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';
import { dbName } from './config.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const dbPath = resolve(__dirname, dbName);

const db = new sqlite3.Database(dbPath, (err) => {
    if (err) {
        console.log("Error opening database " + err.message);
    }
    console.log("Connected to the shop-js database.");
});

export default db;