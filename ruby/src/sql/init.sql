CREATE TABLE IF NOT EXISTS `product` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category INTEGER NOT NULL,
    price REAL NOT NULL,
    created_date TEXT NOT NULL,
    description TEXT NULL,
    link TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `product_detail` (
    id INTEGER PRIMARY KEY,
    id_product INTEGER NOT NULL, 
)