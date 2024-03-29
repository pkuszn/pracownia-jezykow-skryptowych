-- sqlite3

CREATE TABLE IF NOT EXISTS `product` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category INTEGER NOT NULL,
    price REAL NOT NULL,
    created_date TEXT NOT NULL,
    description TEXT NULL,
    available INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS `purchase` (
    id INTEGER PRIMARY KEY,
    id_product INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    purchase_date TEXT NOT NULL,
    delivery_type INTEGER NOT NULL,
    payment_type INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS `user` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    password TEXT NOT NULL,
    address TEXT NOT NULL,
    created_date TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `delivery_type` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `payment_type` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `category` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

-- mysql 

CREATE TABLE IF NOT EXISTS `product` (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_date DATETIME NOT NULL,
    description TEXT NULL,
    available INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS `purchase` (
    id INTEGER PRIMARY KEY,
    id_product INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    purchase_date DATETIME NOT NULL,
    delivery_type INTEGER NOT NULL,
    payment_type INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS `user` (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    created_date DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS `delivery_type` (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `payment_type` (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `category` (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);