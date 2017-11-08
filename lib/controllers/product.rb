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

        print "Would you like to proceed with this active customer? (Y/N) "
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
        db.close
        return true
    end



    # list_saved_products pulls all products from database and organizes them based on product_id.
    # Author: Matt Minner and Daniel Greene.

    #CHECK FOR ACTIVE CUSTOMER EACH TIME
    def self.add_product_to_active_customer_order
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? "
        proceed = gets.upcase.chomp

        if proceed == "Y"
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Add Product to a Customer Order **")
            add_product_to_order = self.list_saved_products

        else
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Add Product to a Customer Order **")
            add_product_to_order = self.list_saved_products     
        end
        
    end
   
    

    def self.list_saved_products
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * From products"
        ids = []
        products = all_products.to_a
        puts "\n Which product would you like?\n\n".upcase
        products.each do |product_id, price, title| 
            print "#{product_id}" + ". " + "#{title}\n"
            ids.push(product_id)
        end
        print "#{products.length + 1}. Type done to exit\n"
       
        product_to_add = gets.upcase.chomp
        if ids.include?(product_to_add.to_i) 
            product_to_add.to_i
            get_order_id = self.get_order_id
            db = SQLite3::Database.open("bangazon_store.sqlite")
            get_product = db.execute("SELECT * From products where product_id = #{product_to_add}")
            db.execute("INSERT INTO order_products(price, seller_id, order_id, product_id) VALUES(?,?,?,?)", ["#{get_product[0][1]}", "#{$ACTIVE_CUSTOMER_ID}", "#{get_order_id}", "#{get_product[0][0]}"])
            self.list_saved_products
        else
            
        end
        
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
        # product_to_add = gets.upcase.chomp
        # unless product_to_add == "DONE" || ids.include?(product_to_add)
        #     product_to_add.to_i
        #     get_order_id = self.get_order_id
        #     db = SQLite3::Database.open("bangazon_store.sqlite")
        #     get_product = db.execute("SELECT * From products where product_id = #{product_to_add}")
        #     db.execute("INSERT INTO order_products(price, seller_id, order_id, product_id) VALUES(?,?,?,?)", ["#{get_product[0][1]}", "#{$ACTIVE_CUSTOMER_ID}", "#{get_order_id}", "#{get_product[0][0]}"])
        #     self.list_saved_products
        # else

        # end
    end

    # import_products Pulls all products that are not on an order from the database.    
    # Author: Austin Kuirts  
    def self.import_products
        products = []
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_products = db.prepare "SELECT * FROM products WHERE product_id NOT IN (SELECT product_id FROM order_products) AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
        products = all_products
    end

    # This method starts the removal of a product
    # Author: Austin Kurtis
    # This Method first calls the active customer and confirms the use has the one wanted.
    def self.remove_product_customer
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? Y/N: "
        proceed = gets.upcase.chomp

        if proceed == "Y" 
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Select a Product to Remove **")
            remove_product = self.remove_product

        else
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Select a Product to Remove **")
            remove_product = self.remove_product        
        end
    end
    # Starts the remove product process by brining in the list of products for active customer
    def self.remove_product
        sleep(0.75)
        productIds = []
        products = self.import_products
        print "\n"
        products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        productIds.push(product_id)
        end
        
        # checks to see if the active customer has products if not asks to add products or goes forward
        if productIds.empty?
            print "This customer has no products. Would you like to add a product? Y/N: "
            selection = gets.upcase.chomp
        if selection == "Y"
                self.add_product_to_active_customer
                elsif selection =="N"
            else
                print "Unrecognized selection".upcase
                self.remove_product
        end
        else
            # starts the delete product process
            print "\n Type EXIT to return to main menu:\n".upcase
            print "\n Choose a Product to delete: ".upcase
            product_to_delete = gets.chomp
            if productIds.include?(product_to_delete.to_i)
                db = SQLite3::Database.open("bangazon_store.sqlite")
                db.execute "DELETE FROM products WHERE product_id = #{product_to_delete} AND seller_id = #{$ACTIVE_CUSTOMER_ID} "
                db.close
                system "clear" or system "cls"
            elsif product_to_delete.upcase == "EXIT"

            else
                print "Unrecognized selection\n".upcase
                    self.remove_product
            end

        end

     
    end
    
    # Update product method call
    # Author Austin Kurtis
    # This Method first calls the active customer and confirms the use has the one wanted.
    def self.update_product_customer
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? Y/N: "
        proceed = gets.upcase.chomp

        if proceed == "Y" 
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Select a Product to Update **")
            update_product = self.update_product

        else
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Select a Product to Update **")
            update_product = self.update_product        
        end
    end
    # self.update_product pulls in the list of products of the active customer if any exits and returns the products id and product title
    def self.update_product
        sleep(0.75)
        update_productIds = []
        update_products = self.import_products
        print "\n"
        # pulls in the list of products
        update_products.each do |product_id, price, title| 
        print "#{product_id}" + ". " + "#{title}\n"
        update_productIds.push(product_id)
        end
       
        # if the products are empty prompt to add products
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
            # Asks input to choose a product then lists the attributes for change
            print "\n Type EXIT to return to main menu:\n".upcase
            print "\n Choose a Product to update: ".upcase
            select_product_to_update = gets.chomp
            if update_productIds.include?(select_product_to_update.to_i)
                product_to_update = []
                db = SQLite3::Database.open("bangazon_store.sqlite")
                db_update_request = db.execute "SELECT * FROM products WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                product_to_update = db_update_request
                product_to_update.each do |product_id, price, title, description, quantity|
                    
                    print "\n\n1. Change title: #{title}\n"
                    print "2. Change description: #{description}\n"
                    print "3. Change price: $#{price}\n"
                    print "4. Change quantity: #{quantity}\n\n"
                    
                end
                print "\n\nSelect an option to update: "
                update_selection = gets.chomp.to_i
                
                case update_selection
                # Gets user input and updates the title within the database upon hitting enter and exits to the main menu.
                when 1
                    print "\nUpdate Title: "
                    new_title = gets.chomp
                    db = SQLite3::Database.open("bangazon_store.sqlite")
                    db_update_title = db.execute "UPDATE products
                    SET title = '#{new_title}'
                    WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                    db.close
                # Gets user input and updates the description within the database upon hitting enter and exits to the main menu.
                when 2
                    print "\nUpdate Description: "
                    new_description = gets.chomp
                    db = SQLite3::Database.open("bangazon_store.sqlite")
                    db_update_description = db.execute "UPDATE products
                    SET description = '#{new_description}'
                    WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                    db.close
                # Gets user input and updates the price within the database upon hitting enter and exits to the main menu.
                when 3
                    print "\nUpdate Price: $"
                    new_price = gets.chomp.to_f 
                    price_round = (new_price).round(2)
                    db = SQLite3::Database.open("bangazon_store.sqlite")
                    db_update_price = db.execute "UPDATE products
                    SET price = #{price_round}
                    WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                    db.close
                # Gets user input and updates the quantity within the database upon hitting enter and exits to the main menu.
                when 4
                    print "\nUpdate Quantity: "
                    new_quantity = gets.chomp.to_i
                    db = SQLite3::Database.open("bangazon_store.sqlite")
                    db_update_Quantity = db.execute "UPDATE products
                    SET quantity = #{new_quantity}
                    WHERE product_id = #{select_product_to_update} AND seller_id = #{$ACTIVE_CUSTOMER_ID}"
                    db.close
                else
                    print "\nUnrecognized selection".upcase
                end
            
            elsif select_product_to_update.upcase == "EXIT"
    
            else
                print "Unrecognized selection\n".upcase
                    self.update_product
            end
        end
        
    end

# SHOW STALE PRODUCTS
#Author: Matt Minner

def self.stale_products
    db = SQLite3::Database.open("bangazon_store.sqlite")
    stale_products = db.execute "SELECT p.product_id, p.title, p.date_added FROM products p  WHERE strftime('%m', 'now') - strftime('%m', p.date_added) >= 6 and product_id NOT IN (SELECT product_id FROM order_products)
                                 union 
                                 SELECT p.product_id, p.title, p.date_added FROM products p JOIN order_products op JOIN orders o WHERE p.product_id = op.product_id and op.order_id = o.order_id and o.payment_id NOT IN (SELECT payment_id FROM orders) and strftime('%m', 'now') - strftime('%m', o.created_date) >= 3 
                                 union 
                                 SELECT p.product_id, p.title, p.date_added FROM products p JOIN order_products op JOIN orders o WHERE p.product_id = op.product_id and op.order_id = o.order_id and EXISTS (SELECT payment_id FROM orders) and quantity > 0 and  strftime('%m', 'now') - strftime('%m', p.date_added) >= 6;"

    list_stale_products = stale_products.to_a
    system "clear" or system "cls"
    puts "\n Products that follow stale criteria\n\n".upcase
    list_stale_products.each do |product_id, title, date_added| 
        print "#{product_id}" + ". " + "#{title}" " #{date_added}\n"
    end
end

# OVERAL PRODUCT POPULARITY
#Author: Daniel Greene

def self.product_popularity
    db = SQLite3::Database.open("bangazon_store.sqlite")
    popularity = db.execute 'SELECT p.title, count(op.product_id) "Orders", count(DISTINCT o.customer_id) "Purchasers", sum(p.price) "Revenue" FROM products p, order_products op, orders o WHERE op.product_id = p.product_id AND op.order_id = o.order_id GROUP BY p.title ORDER BY "Revenue" DESC LIMIT 3;'
    system "clear" or system "cls"
    line0 = " " << "\nProduct".ljust(20)
    line0 << " " + "Orders".ljust(11)
    line0 << " " + "Purchasers".ljust(15)
    line0 << " " + "Revenue".ljust(15)
    puts line0
    puts "*" * 60
    popularity.each do |title, orders, purchasers, revenue|
    line =  " " << "#{title}".ljust(20)
    line << " " + "#{orders}".ljust(11)
    line << " " + "#{purchasers}".ljust(15)
    line << " " + "#{revenue.round(2)}".ljust(15)
    puts line
    end
    puts "*" * 60
    first_val = popularity[2][3]
    second_val = popularity[1][3]
    third_val = popularity[0][3]
    total_val = first_val + second_val + third_val
    line2 =  " " << "TOTALS:".ljust(20)
    line2 << " " + "#{popularity[2][1] + popularity[1][1] + popularity[0][1]}".ljust(11)
    line2 << " " + "#{popularity[2][2] + popularity[1][2] + popularity[0][2]}".ljust(15)
    line2 << " " + "#{total_val.round(2)}"
    puts line2
    db.close
end



    private
    
        def self.output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end

end