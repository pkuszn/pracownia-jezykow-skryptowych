#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require_relative 'product'

# https://www.amazon.pl/Tata-Tea-Gold-czarna-herbata/dp/B0050D3VG2?ref_=Oct_d_orecs_d_20851859031_0&pd_rd_w=mPvzV&content-id=amzn1.sym.09bca5b0-e060-4c0e-b3e0-8582816fa747&pf_rd_p=09bca5b0-e060-4c0e-b3e0-8582816fa747&pf_rd_r=PC66RVF2HKQAJ4G8P4CX&pd_rd_wg=wuxnj&pd_rd_r=fc18b11f-e35c-4df0-a25d-54acc612f6a7&pd_rd_i=B0050D3VG2

class Scraper
    def initialize(base_url)
        @base_url = base_url
    end

    def doc()
        doc = Nokogiri::HTML(URI.open(@base_url, 'User-Agent' => 'ruby'))

        return doc
    end

    def doc_loop(pages)
        products = []
        attribute = "div[data-category]"
        pages.times do |page|
            url = "#{@base_url}/#{page+1}"
            doc = Nokogiri::HTML(URI.open(url, 'User-Agent' => 'ruby'))
            
            product_elements = doc.css('.product.product_view-extended')

            product_elements.each do |product_element|
              category = product_element['data-category']
              producer = product_element['data-producer']
              name = product_element.css('.productname').text.strip
              price = product_element.css('.price em').text.strip
              link = product_element.at_css('.prodimage')['href'] if product_element.at_css('.prodimage')
                    
              product = Product.new(category, producer, name, price, link)
              products << product
            end
      
            sleep(1)
        end
        return products
    end

    def scrap_attribute(doc, tag, attribute, value)
        attribute = "#{tag}[#{attribute}=#{value}]"
        extract = doc.at_css(attribute)

        return extract
    end

    def save_to_file(doc, filename)
        File.write("html/#{filename}.html", doc)
    end

    def scrap_paginator(doc)
        attribute = "ul[paginator]"
        paginator = doc.at_css(attribute)

        return paginator
    end

    def scrap_category(doc, category)
        attribute = "div[data-category='#{category}']"
        products = doc.at_css(attribute)

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

