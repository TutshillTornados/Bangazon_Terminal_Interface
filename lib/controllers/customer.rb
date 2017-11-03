# Customer Controller
# Author: Dev Team
# Creates and saves a new customer 

require 'store'
require 'sqlite3'

class Customer
       attr_accessor :first_name, :last_name, :street, :city, :state, :zip, :phone

       def initialize(first_name:, last_name:, street:, city:, state:, zip:, phone:)
           @first_name = first_name
           @last_name = last_name
           @street = street
           @city = city
           @state = state
           @zip = zip
           @phone = phone
       end

    # A new customer is created by calling add_using_questions and save_customer methods
    def self.create_a_customer_account
        system "clear" or system "cls"
        output_action_header("** Create a Customer Account **")
        add_customer = self.add_using_questions
        if add_customer.save_customer
            system "clear" or system "cls"
        else
            puts "SAVE ERROR: Customer not added"
        end
    end

    def self.add_using_questions
        args = {}
        print "What is the customer's FIRST name? "
        args[:first_name] = gets.chomp.upcase.strip

        print "What is the customer's LAST name? "
        args[:last_name] = gets.chomp.upcase.strip

        print "What is the customer's street address? "
        args[:street] = gets.chomp.upcase.strip

        print "Customer's city? "
        args[:city] = gets.chomp.upcase.strip

        print "Customer's state? "
        args[:state] = gets.chomp.upcase.strip

        print "Customer's ZIP? "
        args[:zip] = gets.chomp.upcase.strip

        print "Customer's phone number? "
        args[:phone] = gets.chomp.upcase.strip
        
        return self.new(args)
    end

    def save_customer
        return false unless DatabaseAdmin.file_useable?
            db = SQLite3::Database.open("bangazon_store.sqlite")
            db.execute("INSERT INTO customers(first_name, last_name, street, city, state, zip, phone) VALUES(?, ?, ?, ?, ?, ?, ?)", ["#{@first_name}", "#{@last_name}", "#{@street}", "#{@city}", "#{@state}", "#{@zip}", "#{@phone}"])
            db.close
        return true
    end

    def self.saved_customers
        customers = []
        db = SQLite3::Database.open("bangazon_store.sqlite")
        all_customers = db.prepare "SELECT * From customers"
        customers = all_customers
    end 

    #    Contiues check for AC from store.rb
    def self.active_customer
            p $ACTIVE_CUSTOMER
            p $ACTIVE_CUSTOMER_ID
    end

    # Formats headers to be sexy
    def self.output_action_header(text)
        puts "#{text.upcase.center(60)}"
    end
end
