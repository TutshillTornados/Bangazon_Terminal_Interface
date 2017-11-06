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
        customer = 522
        db = SQLite3::Database.open("bangazon_store.sqlite")
        messed = db.execute "SELECT * FROM orders WHERE customer_id = ?", customer
        db.close
        messed_up = messed.any?
        assert_equal false, messed_up
    end


end