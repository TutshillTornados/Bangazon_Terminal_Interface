# Author: Dr. T
# testing for customer rev report features

require 'minitest/autorun'
require "sqlite3"

class CustomerRevTest  < Minitest::Test
    def test_check_active_customer_rev
        $ACTIVE_CUSTOMER_ID = 15
        assert($ACTIVE_CUSTOMER_ID == 15)
    end

    def test_db_response
        db = SQLite3::Database.open("bangazon_store.sqlite")
        seller_totals = db.execute("SELECT p.title, op.*
        FROM order_products op JOIN products p
        WHERE  op.product_id =  p.product_id
        AND op.seller_id = #{$ACTIVE_CUSTOMER_ID}")
        assert(true, seller_totals.empty?)
    end
end