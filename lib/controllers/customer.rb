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

       def make_customer_active
        puts "LIST"
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

end