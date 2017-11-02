# Author: Dr. Teresa Vasquez
# Builds the database and all the tables
# run in the command line: ruby lib/database_admin/build_database.rb


require 'sqlite3'

begin
    # this opens the DB and adds the tables unless they already exist
    db = SQLite3::Database.new("bangazon_store.sqlite")
    db.execute("PRAGMA foreign_keys = ON")
    customers = db.execute <<-SQL 
        CREATE TABLE customers(
        customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name varchar(50),
        last_name varchar(50),
        street varchar(100),
        city varchar(58),
        state varchar(2),
        zip INTEGER(5),
        phone INTEGER
        );
        SQL
    payments = db.execute <<-SQL 
        CREATE TABLE payments(
        payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
        account INTEGER,
        name varchar(10),
        customer_id INTEGER,
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        );
        SQL
    products = db.execute <<-SQL 
        CREATE TABLE products(
        product_id INTEGER PRIMARY KEY AUTOINCREMENT,
        price INTEGER,
        title INT,
        description varchar(100),
        quantity INTEGER,
        date_added DATE,
        seller_id INTEGER,
        FOREIGN KEY (seller_id) REFERENCES customers(customer_id)
        );
        SQL
    orders = db.execute <<-SQL 
        CREATE TABLE orders(
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        total INTEGER,
        payment_id INTEGER,
        customer_id INTEGER,
        FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        );
        SQL
    order_products = db.execute <<-SQL 
        CREATE TABLE order_products(
        orders_products_id INTEGER PRIMARY KEY AUTOINCREMENT,
        price INTEGER,
        seller_id INTEGER,
        order_id INTEGER,
        product_id INTEGER,
        FOREIGN KEY (seller_id) REFERENCES customers(customer_id),
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        );
        SQL
    
    puts customers
    puts payments
    puts products
    puts orders
    puts order_products

    # Close Database
    db.close if db # It is a good habit to close the db when done.
    
    rescue SQLite3::Exception => e
    # p "Exception with DB query: #{e}"
end