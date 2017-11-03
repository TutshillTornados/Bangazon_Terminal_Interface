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
        output_action_header("** Create a Customer Product **")
        add_products = self.add_product
        if add_products.save_product
            system "clear" or system "cls"
        else
            puts "SAVE ERROR:product not added"
        end
    end

    def self.add_product
        args = {}
        print "What is the price of the product? "
        args[:price] = gets.chomp.upcase.strip

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
        db.execute("INSERT INTO products(price, title, description, quantity, date_added, seller_id) VALUES(?, ?, ?, ?, ?, ?)", ["#{@price}", "#{@title}", "#{@description}", "#{@quantity}", "#{Date.today}" "#{$ACTIVE_CUSTOMER}"])
        #Add active customerId as SellerId to table
        #Add current date to date_added on table
        db.close
        return true
    end

# import_products Pulls all products that are not on an order from the database.    
# Author: Austin Kuirts    
    def self.import_products
        products = []
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_products)"
        products = all_products
    end
# remove_product method Prints All Products that are not on an order. User selects a product. Selection Deletes product and returns to the store front.
# Author: Austin Kuirts
    def self.remove_product
        print "\n Choose a Product to delete:\n\n".upcase
        sleep(0.75)
        products = self.import_products
        products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        end
        print "Choose a Product to delete:\n".upcase
        product_to_delete = gets.chomp
        db = SQLite3::Database.open("bangazon_store.sqlite")
        db.execute "DELETE FROM products WHERE product_id = #{product_to_delete}"
        db.close
        system "clear" or system "cls"
    end

    def update_product
    end

    private
    
        def self.output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end

end