#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require_relative 'product'
require_relative 'product_details'

class Scraper
    def initialize(base_url, category_url)
        @base_url = base_url
        @category_url = category_url
    end

    def doc()
        doc = Nokogiri::HTML(URI.open(@base_url, 'User-Agent' => 'ruby'))
        return doc
    end

    #TODO: Category request
    def doc_loop(pages, last_index)
        products = []
        counter = last_index
        pages.times do |page|
            url = "#{@category_url}/#{page+1}"
            doc = Nokogiri::HTML(URI.open(url, 'User-Agent' => 'ruby'))
            
            product_elements = doc.css('.product.product_view-extended')

            product_elements.each do |product_element|
              category = product_element['data-category']
              producer = product_element['data-producer']
              name = product_element.css('.productname').text.strip
              price = product_element.css('.price em').text.strip
              link = product_element.at_css('.prodimage')['href'] if product_element.at_css('.prodimage')
                    
              counter += 1
              product = Product.new(counter, category, producer, name, price, link, nil)

              scrap_details(link, product)

              products << product
            end
      
            sleep(1)
        end
        return products
    end

    def scrap_details(link, product)
        uri = "#{@base_url}#{link}"
        puts uri
        doc = Nokogiri::HTML(URI.open(uri, 'User-Agent' => 'ruby'))

        id_product = product.id
        brand = get_text_content(doc, 'td.name:contains("Marka") + td.value')
        type_of_tea = get_text_content(doc, 'td.name:contains("Rodzaj herbaty") + td.value')
        type_of_additives = get_text_content(doc, 'td.name:contains("Rodzaje dodatków") + td.value')
        packaging_type = get_text_content(doc, 'td.name:contains("Rodzaj opakowania") + td.value')
        packaging_form = get_text_content(doc, 'td.name:contains("Forma pakowania") + td.value')
        number_of_tea_bags = get_text_content(doc, 'td.name:contains("Ilość torebek") + td.value')
        grams = get_text_content(doc, 'td.name:contains("Ilość gramów") + td.value')
        set_value = get_text_content(doc, 'td.name:contains("Zestaw") + td.value')
        fair_trade_cert = get_text_content(doc, 'td.name:contains("Certyfikat Fair Trade") + td.value')
        usda_organic_cert = get_text_content(doc, 'td.name:contains("Certyfikat USDA Organic") + td.value')
        organic_farming_cert = get_text_content(doc, 'td.name:contains("Certyfikat Rolnictwa Ekologicznego") + td.value')
        other_cert = get_text_content(doc, 'td.name:contains("Inne certyfikaty ekologiczne") + td.value')
      
        product_details = ProductDetails.new(id_product, brand, type_of_tea, type_of_additives, packaging_type, packaging_form, grams, number_of_tea_bags, set_value, fair_trade_cert, usda_organic_cert, organic_farming_cert, other_cert)
        
        product_details.to_string()

        product.details = product_details
        save_to_file(product.details, link)
    end

    def scrap_attribute(doc, tag, attribute, value)
        attribute = "#{tag}[#{attribute}=#{value}]"
        extract = doc.at_css(attribute)

        return extract
    end

    def get_text_content(doc, css_selector)
        element = doc.at_css(css_selector)
        element ? element.text.strip : nil
      end

    def save_to_file(doc, filename)
        begin
          File.write("html/#{filename}.html", doc)
          puts "File saved successfully!"
        rescue StandardError => e
          puts "Error saving file: #{e.message}"
        end
    end

    def scrap_category(doc, category)
        attribute = "div[data-category='#{category}']"
        products = doc.at_css(attribute)

        return products
    end
end

