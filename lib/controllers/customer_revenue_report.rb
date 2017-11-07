#AUTHOR: Dr. T
# queries DB for customer rev report

require 'sqlite3'
class CustomerRevenue

    def get_customer_rev_report
        db = SQLite3::Database.open("bangazon_store.sqlite")
        seller = db.prepare "SELECT * From products where seller_id = #{ACTIVE_CUSTOMER_ID}"
    end


end

# Given a customer requests their overall revenue
# When the user selects the corresponding option from the main menu
# Then the user should be presented with the following report

# Revenue report for Svetlana:

# Order #34
# ----------------------------------------------------
# Marble                          15         $21.43

# Order #109
# ----------------------------------------------------
# Kite                            1          $5.12
# Marble                          5          $5.52

# Total Revenue: $32.07