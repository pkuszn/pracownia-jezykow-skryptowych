#! /usr/bin/env ruby

class ProductDetails
    attr_accessor :id_product, :brand, :type_of_tea, :type_of_additives, :packaging_type, :packaging_form, :number_of_tea_bags, :grams, :set_value, :fair_trade_cert, :usda_organic_cert, :organic_farming_cert, :other_cert
    def initialize(id_product, brand, type_of_tea, type_of_additives, packaging_type, packaging_form, grams, number_of_tea_bags, set_value, fair_trade_cert, usda_organic_cert, organic_farming_cert, other_cert)
      @id_product = id_product
      @brand = brand
      @type_of_tea = type_of_tea
      @type_of_additives = type_of_additives
      @packaging_type = packaging_type
      @packaging_form = packaging_form
      @number_of_tea_bags = number_of_tea_bags
      @grams = grams
      @set_value = set_value
      @fair_trade_cert = fair_trade_cert
      @usda_organic_cert = usda_organic_cert
      @organic_farming_cert = organic_farming_cert
      @other_cert = other_cert
    end

    def to_string()
        puts "id_product: #{@id_product}"
        puts "brand: #{@brand}"
        puts "type_of_tea: #{@type_of_tea}"
        puts "type_of_additives: #{@type_of_additives}"
        puts "packaging_type: #{@packaging_type}"
        puts "packaging_form: #{@packaging_form}"   
        puts "number_of_tea_bags: #{@number_of_tea_bags}"
        puts "set_value: #{@set_value}"
        puts "fair_trade_cert: #{@fair_trade_cert}"
        puts "usda_organic_cert: #{@usda_organic_cert}"
        puts "organic_farming_cert: #{@organic_farming_cert}"
        puts "other_cert: #{@other_cert}"
     end
 end