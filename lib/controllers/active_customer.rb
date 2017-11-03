# Sets active customer
# Author: Austin and Dr. T

require 'sqlite3'
$:.unshift File.join(File.dirname(__FILE__), ".")
require 'store'

class ActiveCustomer
    
    # prints list of customers in DB from customers table and returns value based on user input
    def self.list
        puts "\n Which customer will be active\n\n".upcase
        customers = Customer.saved_customers
        customers.each do |customer_Id, first_name, last_name| 
            print "#{customer_Id}" + ". " + "#{first_name}" + " " + "#{last_name}\n"
        end
        print "Make a Customer Active: "
        customer = gets.chomp
        
        # Calls to DB using the user input based on list that is printed 
        db = SQLite3::Database.new("bangazon_store.sqlite")
        selected_customer = db.execute "SELECT * FROM customers WHERE customer_id = ?", customer
        db.close

        # Assigning selected customer to $ACTIVE_CUSTOMER
        $ACTIVE_CUSTOMER = { 
            id: selected_customer[0][0], 
            name_first: selected_customer[0][1],
            name_last: selected_customer[0][2]
        }
        
        # Assigning selected customer ID to $ACTIVE_CUSTOMER_ID
        $ACTIVE_CUSTOMER_ID = selected_customer[0][0]
        p "Selected Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}"
    end
end