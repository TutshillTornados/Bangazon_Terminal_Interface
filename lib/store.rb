# This is the VIEW of the MVC Model
# Author: DEV TEAM
# Controls the view for the user

require 'sqlite3'
require 'dba.rb'
require 'controllers/customer'
require 'controllers/order'
require 'controllers/payment_option'
require 'controllers/product'
require 'controllers/active_customer'
require 'controllers/complete_order'
require 'controllers/customer_revenue_report'

class Store

    #configures app so that actions are set and ready for user input from main menu
    class Config
        @@actions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        def self.actions; @@actions; end
    end

    #Initializes the DB and begins process to see if it exists
    def initialize(path=nil)
        DatabaseAdmin.filepath = path
        if DatabaseAdmin.file_useable?
            puts "*" * 60
            output_action_header("**    Welcome to Bangazon Command Line Ordering System    **")
            puts "*" * 60
        elsif DatabaseAdmin.create_file
            puts "*" * 60
            output_action_header("**    Welcome to Bangazon Command Line Ordering System    **")
            puts "*" * 60
        else 
            puts "Exiting. \n\n"
            exit!
        end
    end

    # This begins the program and tells what to do when specific actions happen
        def launch!
            introduction
            # action loop
            result = nil
            until result == :quit do
                action, args = get_action
                result = do_action(action, args)
            end
            conclusion
        end

    # stores user input from main menu options
    def get_action
        action = nil
        # Keep asking for user input until they input a valid action
        until Store::Config.actions.include?(action)
            system "clear" or system "cls" if action
            # output_action_header("*** Input Error ***") if action
            puts "\nSelect an Option:\n1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!" if action
            print "> "
            user_response = gets.chomp
            args = user_response.to_i
            action = args
        end
        return action, args
    end
    
    # Action Loop: accepts customer input and performs methods that coincide with customer input
    def do_action(action, args=[])
        case action
        when 1
            Customer.create_a_customer_account
            output_action_header("\nCustomer Added!")
            between_views
        when 2
            ActiveCustomer.list
            between_views
        when 3
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                Payment.add_payment_to_active_customer
                output_action_header("\nPayment Added!")
                between_views
            else
                Payment.add_payment_to_active_customer
                output_action_header("\nPayment Added!")
                between_views
            end
        when 4
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                Product.add_product_to_active_customer
                output_action_header("\nProduct Added!")
                between_views
            else
                Product.add_product_to_active_customer
                output_action_header("\nProduct Added!")
                between_views
            end
        when 5
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                Product.list_saved_products
                between_views
            else
                Product.list_saved_products
                between_views
            end
        when 6
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                CompleteOrder.get_active_user_order
                between_views
            else
                CompleteOrder.get_active_user_order
                between_views
            end
        when 7
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                Product.remove_product
                between_views
            else
                Product.remove_product
                between_views
            end
        when 8
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                Product.update_product
                between_views
            else
                Product.update_product
                between_views
            end
        when 9
            Product.stale_products
        when 10
            if $ACTIVE_CUSTOMER_ID == nil
                ActiveCustomer.list
                CustomerRevenue.check_active_customer_rev
                between_views
            else
                CustomerRevenue.check_active_customer_rev
                between_views
            end
        when 11
            Product.product_popularity
        when 12
            return :quit
        else
            puts "I don't understand that command"
        end
    end

    # Between actions, the menu displays to prompt the customer
    def between_views
        output_action_header("\n*** What Would You Like To Do Next? ***")
        puts "1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!"
    end

    # Prints intro and welcome message/main menu to interface
    def introduction
        puts "1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!"
    end
    
    # Upon selecting 12: LEAVE BANGAZON - Exit message
    def conclusion
        system "clear" or system "cls"
        output_action_header("**  Thank You For Using The Bangazon Command Line Ordering System  **")
    end

    private

    # Formats headers to be sexy
    def output_action_header(text)
        puts "#{text.upcase.center(60)}"
    end

end
    
