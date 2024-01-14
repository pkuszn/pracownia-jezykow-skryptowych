#! /usr/bin/env ruby

require_relative 'scraper.rb'

uri = "https://herbaciarnia24h.pl/pl/c/Rodzaj-herbaty/334"

scraper = Scraper.new(uri)
products = scraper.doc_loop(5)
scraper.save_to_file(products, "products")

products.each do |product|
    product.to_string
end