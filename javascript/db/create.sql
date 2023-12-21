CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category INTEGER NOT NULL,
    price REAL NOT NULL,
    created_date TEXT NOT NULL,
    description TEXT NULL,
    available BIT NOT NULL,
);

CREATE TABLE purchase (
    id INTEGER PRIMARY KEY,
    id_product INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    purchase_date TEXT NOT NULL,
    delivery_type INTEGER NOT NULL,
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    address TEXT NOT NULL,
);

CREATE TABLE delivery_type (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
);

CREATE TABLE payment_type (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
);

CREATE TABLE category (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
);

