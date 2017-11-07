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
        args[:price] = gets.to_f

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

    # import_products Pulls all products that are not on an order from the database.    
    # Author: Austin Kurtis    
    def self.import_products
        products = []
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_products) AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
        products = all_products
    end

    # list_saved_products pulls all products from database and organizes them based on product_id.
    # Author: Matt Minner and Daniel Greene. 
    def self.list_saved_products
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * From products"
        products = all_products.to_a

        puts "\n Which product would you like?\n\n".upcase
        products.each do |product_id, price, title| 
            print "#{product_id}" + ". " + "#{title}\n"
        end
        print "#{products.length + 1}. Type done to exit\n"
        save_product_to_order
        
    end
    
    #PREP GETTING ORDER ID FOR ORDER_PRODUCT TABLE
    def self.get_order_id
        db = SQLite3::Database.open("bangazon_store.sqlite")
        order = db.execute "SELECT * FROM orders WHERE payment_id IS NULL AND customer_id = '#{$ACTIVE_CUSTOMER_ID}'"
        db.close
        unless order.empty?
            return order[0][0]

        else
            db = SQLite3::Database.open("bangazon_store.sqlite")
            db.execute("INSERT INTO orders(customer_id) VALUES(?)", ["#{$ACTIVE_CUSTOMER_ID}"])
            self.get_order_id
        end

    end

    # gets the user input and queries the database based on product_id. Unless it's the last selection which exits to main menu. 
    def self.save_product_to_order
        product_to_add = gets.upcase.chomp
        if product_to_add == "DONE"
            
        else
            product_to_add.to_i
            get_order_id = self.get_order_id
            db = SQLite3::Database.open("bangazon_store.sqlite")
            get_product = db.execute("SELECT * From products where product_id = #{product_to_add}")
            db.execute("INSERT INTO order_products(price, seller_id, order_id, product_id) VALUES(?,?,?,?)", ["#{get_product[0][1]}", "#{$ACTIVE_CUSTOMER_ID}", "#{get_order_id}", "#{get_product[0][0]}"])
            self.list_saved_products
        end
    end

    def self.remove_product
        sleep(0.75)
        productIds = []
        products = self.import_products
        print "\n"
        products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        productIds.push(product_id)
        print "\n Choose a Product to delete:".upcase
        end
            
        if productIds.empty?
            print "This customer has no products. Would you like to add a product? Y/N: "
            selection = gets.upcase.chomp
        if selection == "Y"
                self.add_product_to_active_customer
                elsif selection =="N"
            else
                print "Unrecongnized selection".upcase
                self.remove_product
        end
        else
            product_to_delete = gets.chomp.to_i
            if productIds.include?(product_to_delete)
                db = SQLite3::Database.open("bangazon_store.sqlite")
                db.execute "DELETE FROM products WHERE product_id = #{product_to_delete} AND seller_id = #{$ACTIVE_CUSTOMER_ID} "
                db.close
                system "clear" or system "cls"
            else
                print "Unrecongnized selection\n".upcase
                    self.remove_product
            end

        end

        
    end


    def update_product
    end

    private
    
        def self.output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end

end