#! /usr/bin/env ruby

require_relative 'scraper.rb'
require_relative 'db.rb'

db_name = "tea.db"
category_uri = "https://herbaciarnia24h.pl/pl/c/Rodzaj-herbaty/334"
base_url = "https://herbaciarnia24h.pl"

db = Database.new(db_name)

last_index = db.last_record()[0]
puts "Set index: #{last_index}"

scraper = Scraper.new(base_url, category_uri)
products = scraper.doc_loop(1, last_index)
scraper.save_to_file(products, "products")

products.each do |product|
    db.insert_product(product)
    db.insert_product_details(product.details)
    puts "Added product with id: #{product.id} to database."
end