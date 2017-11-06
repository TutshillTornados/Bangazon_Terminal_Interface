#COMPLETE ORDER  TEST
# Author: Dr. Teresa Vasquez
# Testing the ability to complete an order

require 'minitest/autorun'
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require 'controllers/complete_order.rb'

class CompleteOrderTest < Minitest::Test
    
    def setup
        $ACTIVE_CUSTOMER_ID = 10
    end

    def test_if_active_customer_is_selected
        assert_equal 10, $ACTIVE_CUSTOMER_ID
    end
  
    def test_error_when_db_call_returns_empty_array
        customer = 22
        db = SQLite3::Database.open("bangazon_store.sqlite")
        messed = db.execute "SELECT * FROM orders WHERE customer_id = ? AND payment_id IS NULL", customer
        db.close
        assert_equal true, messed.any?
    end
end