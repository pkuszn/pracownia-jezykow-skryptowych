#! /usr/bin/env ruby

class Product
   attr_accessor :id, :category, :producer, :name, :price, :link, :details
   def initialize(id, category, producer, name, price, link, details)
      @id = id
      @category = category
      @producer = producer
      @name = name
      @price = price
      @link = link
      @details = details
   end

   def to_string()
      puts "Id: #{@id}"
      puts "Category: #{@category}"
      puts "Producer: #{@producer}"
      puts "Name: #{@name}"
      puts "Price: #{@price}"
      puts "Link: #{@link}"   
      puts "Details: #{@details}"
   end
 end