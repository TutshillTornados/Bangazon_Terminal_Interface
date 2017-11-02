# Author: Dr. Teresa Vasquez
# Drops the orders table
# run in the command line: ruby lib/database_admin/drop_orders.rb

require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP ORDERS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE orders"
db.execute(sqlQuery)
