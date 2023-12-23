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

INSERT INTO `product` (id, name, category, price, created_date, description, available) VALUES
  (1, "Earl Grey", 1, 5.99, '2023-01-01', 'A classic black tea with bergamot flavor', 1),
  (2, "Jasmine Green Tea", 2, 7.99, '2023-01-02', 'Green tea scented with jasmine flowers', 1),
  (3, "Silver Needle", 3, 9.99, '2023-01-03', 'A delicate white tea with silver buds', 1),
  (4, "Tie Guan Yin", 4, 12.99, '2023-01-04', 'An oolong tea with floral and fruity notes', 1),
  (5, "Berry Bliss", 5, 6.99, '2023-01-05', 'Fruit tea blend with berries', 1),
  (6, "Tea Infuser", 6, 4.99, '2023-01-06', 'Stainless steel tea infuser for loose leaf tea', 1);