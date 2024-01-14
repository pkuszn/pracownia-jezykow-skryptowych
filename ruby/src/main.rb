require_relative 'scraper.rb'

scraper = Scraper.new
doc = scraper.doc()
products = scraper.scrap_category(doc, "Herbata Hyleys")
scraper.save_to_file(products)