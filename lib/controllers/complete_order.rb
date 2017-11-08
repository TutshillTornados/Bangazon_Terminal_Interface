# Completes a customer's order
# checks if there is an open order
# if not, redirects to add products
# if so, adds payment to close order
# if no payment, allows user to add payment to customer
# Author: Dr. T

require 'payment_option'

class CompleteOrder

    # upon selection, function gets active user order 
    def self.get_active_user_order
        system "clear" or system "cls"
        puts "ACTIVE CUSTOMER ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? "
        proceed = gets.upcase.chomp

        unless proceed == "Y"
        # if the user does not want to proceed with the currect active user, they can choose another active user and begin the process
        ActiveCustomer.list
        self.get_active_user_order
        
        # if user selects to proceed with current active user, finds open order
        else
        db = SQLite3::Database.open("bangazon_store.sqlite")
        order = db.execute "SELECT * FROM orders WHERE payment_id IS NULL AND customer_id = #{$ACTIVE_CUSTOMER_ID}"
        db.close

        # are there any orders? If no, prints message and starts over
        unless order.any?
        print "Please add some products to your order first. Press ENTER key to return to main menu.\n"
        print "> "
        STDIN.gets(1)
        system "clear" or system "cls"
        
        #if there are orders, begins process to close
            else
            db = SQLite3::Database.open("bangazon_store.sqlite")
            order_total = db.execute("SELECT SUM(price)
            FROM order_products
            WHERE order_id = #{order[0][0]};")
            order_update_price = db.execute "UPDATE orders
            SET total = #{order_total[0][0]}
            WHERE order_id = #{order[0][0]}"
            db.close
            order_total_price = order_total[0][0].to_f.round(2)
            print "** Complete #{$ACTIVE_CUSTOMER[:name_first]}'s Order **\n"
            print "Your order total is $#{order_total_price}. Ready to purchase? (Y/N)"
            print "> "
            close_order = gets.upcase.chomp
               
            # makes call to DB to get customer payment options
            unless close_order == "Y"
                system "clear" or system "cls"
                print "\nEXITING CLOSE ORDER OPTION\n"
            else
                payment_ids = []
                db = SQLite3::Database.open("bangazon_store.sqlite")
                customer_payments = db.execute "SELECT * FROM payments WHERE customer_id = #{$ACTIVE_CUSTOMER_ID}"
                db.close

                print "\n"
                customer_payments.each do |payment_id, account_number, name| 
                payment_ids.push(payment_id)
                print "#{payment_id}" + ". " + "#{name}\n"
                end
                
                # if the customer doesn't have any payment options, the user can add one here...
                if payment_ids.empty?
                print "This customer has no payment options. Would you like to add a payment option? Y/N: "
                selection = gets.upcase.chomp
                        
                    if selection == "Y"
                    Payment.add_payment_to_active_customer
                    self.get_active_user_order

                    elsif selection == "N"
                        self.get_active_user_order
                    else
                    print "Unrecongnized selection".upcase 
                    self.get_active_user_order      
                    end

                # if the customer already has a payment option, this is the code block that runs and adds selected payment option to the order in the DB
                else
                print "\n Choose a payment option: ".upcase
                selected_payment_option = gets.chomp.to_i
                    if payment_ids.include?(selected_payment_option)
                    db = SQLite3::Database.open("bangazon_store.sqlite")
                    db.execute("UPDATE orders
                    SET payment_id = '#{selected_payment_option}' 
                    WHERE order_id = #{order[0][0]}")
                    db.close
                    system "clear" or system "cls"
                    print "\n\n#{$ACTIVE_CUSTOMER[:name_first]}'s PAYMENT ADDED TO ORDER ##{order[0][0]}\n"
                    else
                    print "Unrecongnized selection\n".upcase
                    self.get_active_user_order
                    end   
                end
            end
        end     
        end
    end
end
