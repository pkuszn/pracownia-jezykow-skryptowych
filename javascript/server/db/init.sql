INSERT INTO `delivery_type` (id, name) VALUES
    (1, "Courier"),
    (2, "Post");

INSERT INTO `payment_type` (id, name) VALUES
    (1, "Cash on delivery"),
    (2, "Pay in advance");

INSERT INTO `category` (id, name) VALUES
    (1, "Black teas"),
    (2, "Green teas"),
    (3, "White teas"),
    (4, "Oolong teas"),
    (5, "Fruit teas"),
    (6, "Tea accessories");

INSERT INTO `user` (id, name, surname, address, created_date) VALUES
    (1, "root", "root", "Zabrze", "2023-12-22T20:44:42Z");