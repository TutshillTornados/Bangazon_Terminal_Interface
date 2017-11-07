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

    # import_products Pulls all products that are not on an order from the database.    
    # Author: Austin Kuirts    
    def self.import_products
        products = []
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_products) AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
        products = all_products
    end

    def self.remove_product
        sleep(0.75)
        productIds = []
        products = self.import_products
        print "\n"
        products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        productIds.push(product_id)
        print "\n Type EXIT to return to main menu:\n".upcase
        print "\n Choose a Product to delete: ".upcase
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
            product_to_delete = gets.chomp
            if productIds.include?(product_to_delete.to_i)
                db = SQLite3::Database.open("bangazon_store.sqlite")
                db.execute "DELETE FROM products WHERE product_id = #{product_to_delete} AND seller_id = #{$ACTIVE_CUSTOMER_ID} "
                db.close
                system "clear" or system "cls"
            elsif product_to_delete.upcase == "EXIT"

            else
                print "Unrecongnized selection\n".upcase
                    self.remove_product
            end

        end

     
    end


    def self.update_product
        sleep(0.75)
        update_productIds = []
        update_products = self.import_products
        print "\n"
        update_products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        update_productIds.push(product_id)
        print "\n Type EXIT to return to main menu:\n".upcase
        print "\n Choose a Product to update: ".upcase
        end
        if update_productIds.empty?
            print "This customer has no products. Would you like to add a product? Y/N: "
            selection = gets.upcase.chomp
           if selection == "Y"
                self.add_product_to_active_customer
                elsif selection =="N"
            else
                print "Unrecongnized selection".upcase
                self.update_product
           end
        else
            select_product_to_update = gets.chomp
            if update_productIds.include?(select_product_to_update.to_i)
                product_to_update = []
                db = SQLite3::Database.open("bangazon_store.sqlite")
                db_update_request = db.execute "SELECT * FROM products WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                product_to_update = db_update_request
                product_to_update.each do |product_id, price, title, description, quantity|
                    
                    print "\n\n1. Change title #{title}\n"
                    print "2. Change description #{description}\n"
                    print "3. Change price #{price}\n"
                    print "4. Change quantity #{quantity}\n\n"
                end
                
                print "\n\nSelect an option to update: "
                update_selection = gets.chomp
                
                update_choice = case update_selection
                
                when 1
                    update_title
                when 2
                    update_description
                when 3
                    update_price
                when 4
                    update_quantity
                end

            elsif select_product_to_update.upcase == "EXIT"
    
            else
                print "Unrecongnized selection\n".upcase
                    self.update_product
            end
        end
    end

    def update_title
        print "Update Title"
        new_title = gets.chomp
    end

    def update_description
        print "Update Description"
        new_description = gets.chomp
    end

    def update_price
        print "Update Price"
        new_price = gets.chomp.to_i
    end

    def update_quantity
        print "Update Quantity"
        new_quantity = gets.chomp
    end

    private
    
        def self.output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end

end