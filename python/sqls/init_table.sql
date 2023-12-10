CREATE TABLE "order" (
	"id"	INTEGER,
	"name"	TEXT,
	"dish_name"	TEXT,
	"price"	TEXT,
	"special_requests"	TEXT,
	"quantity"	INTEGER,
	"created_date"	TEXT NOT NULL,
	"delivery_address"	TEXT,
	"preparation_time"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);