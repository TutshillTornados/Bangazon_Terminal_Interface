# Author: Dr. Teresa Vasquez
# Drops the customers table
# run in the command line: ruby lib/database_admin/drop_customers.rb

require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP CUSTOMERS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE customers"
db.execute(sqlQuery)
