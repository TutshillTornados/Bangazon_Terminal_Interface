# SET ACTIVE CUSTOMER ORDER TEST
# Author: Dr. Teresa Vasquez
# Ensuring that Active Customer exists and is set based on list

require "minitest/autorun"
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require 'controllers/active_customer.rb'

class ActiveCustomerTest < Minitest::Test

    def test_if_user_input_is_valid
        customer = 999
        
        # Calls to DB using the user input based on list that is printed 
        db = SQLite3::Database.new("bangazon_store.sqlite")
        selected_customer = db.execute "SELECT * FROM customers WHERE customer_id = ?", customer
        db.close

        unless selected_customer.empty?
        assert_equal false, selected_customer
        end
    end

end