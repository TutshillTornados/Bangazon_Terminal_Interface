# Author: Dr. Teresa Vasquez
# Drops the payments table
# run in the command line: ruby lib/database_admin/drop_payments.rb

require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP PAYMENTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE payments"
db.execute(sqlQuery)
