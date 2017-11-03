# This is the VIEW of the MVC Model
# Author: Dr. Teresa Vasquez
# Controls the view for the user

require 'sqlite3'
require 'dba'
require 'customer'

class Store
    
    class Config
        @@actions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        def self.actions; @@actions; end
        $active_customer
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

    def get_action
        action = nil
        # Keep asking for user input until they input a valid action
        until Store::Config.actions.include?(action)
            system "clear" or system "cls" if action
            output_action_header("*** Input Error ***") if action
            puts "Select a number to run the command:\n1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!" if action
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
            create_a_customer_account
        when 2
            list
        when 3
            puts "3"
        when 4
            puts "4"
        when 5
            puts "5"
        when 6
            puts "6"
        when 12
            return :quit
        else
            puts "I don't understand that command"
        end
    end

    def create_a_customer_account
        system "clear" or system "cls"
        output_action_header("** Create a Customer Account **")
        add_customer = Customer.add_using_questions
        if add_customer.save_customer
            system "clear" or system "cls"
            output_action_header("\nCustomer Added!")
            bewtween_views
        else
            puts "SAVE ERROR: Customer not added"
        end
    end

    # Between actions, the menu displays to prompt the customer
    def bewtween_views
        output_action_header("\n*** What Would You Like To Do Next? ***")
        puts "1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!"
    end

    def introduction
        puts "1. Create a customer account\n2. Choose active customer\n3. Create a payment option\n4. Add product to sell\n5. Add product to shopping cart\n6. Complete an order\n7. Remove customer product\n8. Update product information\n9. Show stale products\n10. Show customer revenue report\n11. Show overall product popularity\n12. Leave Bangazon!"
    end
    
    def conclusion
        system "clear" or system "cls"
        output_action_header("**  Thank You For Using The Bangazon Command Line Ordering System  **")
    end

    private

    def output_action_header(text)
        puts "#{text.upcase.center(60)}"
    end

    # def output_product_table(products=[])                 
    #     print " " + "Product".ljust(33)
    #     print " " + "Orders".ljust(18) + "\n"
    #     print " " + "Customers".ljust(18) + "\n"
    #     print " " + "Revenue".ljust(18) + "\n"
    #     puts "*" * 90
    #     products.each do |product|
    #         line =  " " << product.product.titleize.ljust(33)
    #         line << " " + product.order.titleize.ljust(24)
    #         line << " " + product.customers.titleize.ljust(24)
    #         line << " " + product.revenue.titleize.ljust(24)
    #         puts line
    #     end
    #     puts "No products found" if products.empty?
    #     puts "*" * 90
    # end
        
    def list
        puts "\n Which customer will be active\n\n".upcase
        customers = Customer.saved_customers
        customers.each do |customer_Id, first_name, last_name| 
            print "#{customer_Id}" + ". " + "#{first_name}" + " " + "#{last_name}\n"
        end
    end

end
    
