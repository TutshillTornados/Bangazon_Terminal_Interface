#PRODUCT CONTROLLER 
# Author: Dev Team
# Contains methods to allow user to add product, list products, update product information, and remove product from database. 

require 'store'
require 'date'

class Product
    attr_accessor :price, :title, :description, :quantity
    
    def initialize (price:, title:, description:, quantity:)
        @price = price
        @title = title
        @description = description
        @quantity = quantity
    end


    # ADD PRODUCTS
    def self.add_product_to_active_customer
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? "
        proceed = gets.upcase.chomp

        if proceed == "Y" 
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Create a Customer Product **")
            add_products = self.add_product

        else
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Create a Customer Product **")
            add_products = self.add_product        
        end

        if add_products.save_product
            system "clear" or system "cls"
        else
            puts "SAVE ERROR:product not added"
        end
    end

    def self.add_product
        args = {}
        print "What is the price of the product? "
        args[:price] = gets.chomp.upcase.strip.to_i

        print "What is the title of the product? "
        args[:title] = gets.chomp.upcase.strip
        
        print "What is the description of the product? "
        args[:description] = gets.chomp.upcase.strip

        print "What is the quantity of the product? "
        args[:quantity] = gets.chomp.upcase.strip
        return self.new(args)
    end

    def save_product
        return false unless DatabaseAdmin.file_useable?
        db = SQLite3::Database.open("bangazon_store.sqlite")
        db.execute("INSERT INTO products(price, title, description, quantity, date_added, seller_id) VALUES(?, ?, ?, ?, ?, ?)", ["#{@price}", "#{@title}", "#{@description}", "#{@quantity}", "#{Date.today}", "#{$ACTIVE_CUSTOMER_ID}"])
        #Add active customerId as SellerId to table
        #Add current date to date_added on table
        db.close
        return true
    end

    def import_products
    end

    def remove_product
    end

    def update_product
    end

    private
    
        def self.output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end

end