require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP ORDER-PRODUCTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE order_products"
db.execute(sqlQuery)