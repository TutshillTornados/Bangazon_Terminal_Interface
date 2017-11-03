require 'sqlite3'

class CustomerModel
    
        def self.set_active_customer
            db = SQLite3::Database.new("bangazon_store.sqlite")
            albums = db.execute("select * from customers;")
            p albums
            
            print "Select Customer "
            customer = gets.chomp
            
            $ACTIVE_CUSTOMER = db.execute "SELECT * FROM customers WHERE customer_id = ?", customer
            
            p $ACTIVE_CUSTOMER
        end
end