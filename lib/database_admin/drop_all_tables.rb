require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP CUSTOMERS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE customers"
db.execute(sqlQuery)

###### DROP PRODUCTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE products"
db.execute(sqlQuery)

###### DROP ORDERS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE orders"
db.execute(sqlQuery)

###### DROP PAYMENTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE payments"
db.execute(sqlQuery)

###### DROP ORDER-PRODUCTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE order_products"
db.execute(sqlQuery)