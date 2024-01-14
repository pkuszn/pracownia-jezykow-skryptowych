#! /usr/bin/env ruby

class Product
   attr_reader :category, :producer, :name, :price, :link
   def initialize(category, producer, name, price, link)
      @category = category
      @producer = producer
      @name = name
      @price = price
      @link = link
   end

   def to_string()
      puts "Category: #{@category}"
      puts "Producer: #{@producer}"
      puts "Name: #{@name}"
      puts "Price: #{@price}"
      puts "Link: #{@link}"      
   end
 end