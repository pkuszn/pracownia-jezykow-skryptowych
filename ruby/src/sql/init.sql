CREATE TABLE IF NOT EXISTS `product` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category INTEGER NOT NULL,
    producer TEXT NOT NULL,
    price REAL NOT NULL,
    created_date TEXT NOT NULL,
    link TEXT NOT NULL
);

 CREATE TABLE IF NOT EXISTS `product_details` (
    id INTEGER PRIMARY KEY,
    id_product INTEGER NOT NULL,
    brand TEXT,
    type_of_tea TEXT,
    type_of_additives TEXT,
    packaging_type TEXT,
    packaging_form TEXT,
    number_of_tea_bags INTEGER,
    grams REAL,
    set_value TEXT,
    fair_trade_cert TEXT,
    usda_organic_cert TEXT,
    organic_farming_cert TEXT,
    other_cert TEXT
  );