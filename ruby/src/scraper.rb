#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

# https://www.amazon.pl/Tata-Tea-Gold-czarna-herbata/dp/B0050D3VG2?ref_=Oct_d_orecs_d_20851859031_0&pd_rd_w=mPvzV&content-id=amzn1.sym.09bca5b0-e060-4c0e-b3e0-8582816fa747&pf_rd_p=09bca5b0-e060-4c0e-b3e0-8582816fa747&pf_rd_r=PC66RVF2HKQAJ4G8P4CX&pd_rd_wg=wuxnj&pd_rd_r=fc18b11f-e35c-4df0-a25d-54acc612f6a7&pd_rd_i=B0050D3VG2

class Scraper

    def doc()
        doc = Nokogiri::HTML(URI.open('https://herbaciarnia24h.pl/herbata-english-tea-shop', 'User-Agent' => 'ruby'))

        return doc
    end

    def save_to_file(doc)
        File.write("doc.html", doc)
    end

    def scrap_category(doc, category)
        attribute = "div[data-category=Herbata Tet A Tea]"
        products = doc.css(attribute)

        return products
    end

    def scrap_category_with_details()

    end 
end


# category
# producer
# name
# price
# link

# Main (div.data-product-id)

# data-product-id
# data-category
# data-producer

# div.product-inner-wrap

#     a.prodname f-row
#         span.product.name
#             <>

#     f-row manufacturer
#         brand
#             title

#     product__basket
#         price f-row
#             <p>



# doc.css('nav ul.menu li a', 'article h2').each do |link|
#   puts link.content
# end

# doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
#   puts link.content
# end

# doc.search('nav ul.menu li a', '//article//h2').each do |link|
#   puts link.content
# end

