# ORDER CONTROLLER
# Author: Dev Team
# Contains the methods that allow user to add products to order. 
require 'store'

class Order 
    def add_product_to_order
        attr_accessor :order_products_id, :price, :seller_id, :order_id, :product_id
        
        def initialize (order_products_id, price, seller_id, order_id, product_id)
            @order_products_id = order_products_id
            @price = price
            @seller_id = seller_id
            @order_id = order_id
            @product_id = product_id
        end
    
    
        # ADD PRODUCTS
        def self.add_order_to_order_product_table
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
    
            print "Would you like to proceed with this active customer? "
            proceed = gets.upcase.chomp
    
            if proceed == "Y" 
                system "clear" or system "cls"
                puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
                output_action_header("** Create a Order **")
                add_products = self.list_saved_products
    
            else
                ActiveCustomer.list
                system "clear" or system "cls"
                puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
                output_action_header("** Create a Order **")
                add_products = self.list_saved_products       
            end
    
            if add_products.save_product
                system "clear" or system "cls"
            else
                puts "SAVE ERROR:order product not added"
            end
        end
    
        def save_product_to_order
            return false unless DatabaseAdmin.file_useable?
            db = SQLite3::Database.open("bangazon_store.sqlite")
            db.execute("INSERT INTO order_products(order_products_id, price, seller_id, order_id, product_id) VALUES(?, ?, ?, ?, ?)", ["#{@order_products_id}", "#{@price}", "#{@seller_id}", "#{@order_id}", "#{product_id}"])
            db.close
            return true
        end

        private
        
            def self.output_action_header(text)
                puts "#{text.upcase.center(60)}"
            end
    
    end
end