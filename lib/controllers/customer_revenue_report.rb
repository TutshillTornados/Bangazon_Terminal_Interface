#AUTHOR: Dr. T
# queries DB for customer rev report

require 'sqlite3'

class CustomerRevenue

    def self.check_active_customer_rev
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? "
        proceed = gets.upcase.chomp

        unless proceed == "Y" 
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            self.get_customer_rev_report
        else
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            self.get_customer_rev_report   
        end
    end

    def self.get_customer_rev_report
        db = SQLite3::Database.open("bangazon_store.sqlite")
        seller_totals = db.execute("SELECT p.title, op.*
        FROM order_products op JOIN products p
        WHERE  op.product_id =  p.product_id
        AND op.seller_id = #{$ACTIVE_CUSTOMER_ID}")

        seller_order_ids = []
        seller_totals.each do |title, order_products_id, price, seller_id, order_id, product_id| 
            unless seller_order_ids.include?(order_id)
                seller_order_ids.push(order_id)
            end
        end

        products_array = {}
        seller_totals.each do |title, order_products_id, price, seller_id, order_id, product_id| 
            seller_order_ids.each do |other_order_id|
                if order_id == other_order_id
                    products_array[order_id] = Array.new if products_array[order_id].nil?
                    products_array[order_id]<<[title, product_id, price]
                end
            end
        end
        system "clear" or system "cls"
        print "\nRevenue report for #{$ACTIVE_CUSTOMER[:name_first]}:\n"
        products_array.each_pair {|key, value| 
        puts "\nOrder ##{key} \n"
        puts "-" * 70
            value.each do |title, product_id, price|
            line =  " " << "#{title}".ljust(33)
            line << " " + "#{product_id}".ljust(24)
            line << " " + "#{price}".ljust(24)
            puts line
            
            end
        }

        db = SQLite3::Database.open("bangazon_store.sqlite")
        seller_revenue = db.execute("SELECT SUM(price)
        FROM order_products
        WHERE seller_id = #{$ACTIVE_CUSTOMER_ID};")
        seller_rev_float = seller_revenue[0][0].to_f.round(2)
        
        print "\nTotal Revenue: $" + "#{seller_rev_float}" + "\n\n"

    end

    private
    
        # Formats headers to be sexy
        def output_action_header(text)
            puts "#{text.upcase.center(60)}"
        end
end