#! /usr/bin/env ruby

require "sqlite3"

class Database
    def initialize(database_name)
        @db = SQLite3::Database.new(database_name)
    end

    def insert_product_details(product_details)
        @db.execute("INSERT INTO product_details (id_product, brand, type_of_tea, type_of_additives, packaging_type, packaging_form, number_of_tea_bags, grams, set_value, fair_trade_cert, usda_organic_cert, organic_farming_cert, other_cert) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [
                product_details.id_product, 
                product_details.brand,
                product_details.type_of_tea, 
                product_details.type_of_additives, 
                product_details.packaging_type, 
                product_details.packaging_form, 
                product_details.number_of_tea_bags, 
                product_details.grams, 
                product_details.set_value, 
                product_details.fair_trade_cert, 
                product_details.usda_organic_cert, 
                product_details.organic_farming_cert, 
                product_details.other_cert
        ]
    )
    end

    def insert_product(product)
        current_datetime = Time.now
        formatted_datetime = current_datetime.strftime("%Y-%m-%d %H:%M:%S")
        @db.execute("INSERT INTO product (category, producer, name, price, created_date, link) VALUES (?, ?, ?, ?, ?, ?)",
                     [product.category, product.producer, product.name, product.price, formatted_datetime, product.link])
    end

    def last_record()
        last_record = @db.execute("SELECT * FROM product ORDER BY id DESC LIMIT 1;").first
        return last_record
    end

end
