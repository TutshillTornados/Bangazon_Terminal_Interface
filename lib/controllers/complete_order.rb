# Completes a customer's order
# Author: Dr. T

class CompleteOrder
# A customer can only have one open order at a time, but it is possible for the customer to have no open orders

# Given a customer has been made active in the program
# When the user selects the option to complete an order
# Then the user should be prompted to choose one of the active customer's payment options

# And when one is chosen, the payment option should be added to the open order
    def self.get_active_user_order
        db = SQLite3::Database.open("bangazon_store.sqlite")
        order = db.execute("SELECT * FROM orders WHERE (customer_id, payment_id) VALUES(?, ?)", ["#{$ACTIVE_CUSTOMER_ID}", "NULL"])
        db.close
        unless order.any?
            "Don't got!"
        else
            "Got an order"
        end
    end
# If no products have been selected yet

# Please add some products to your order first. Press any key to return to main menu.
# If there are current products in an order

# Your order total is $149.54. Ready to purchase
# (Y/N) >

# # If user entered Y
# Choose a payment option
# 1. Amex
# 2. Visa
# >


## RAISE ERRORS IN THE CODE BLOCK!!!!!
end
