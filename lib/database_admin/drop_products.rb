require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP PRODUCTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE products"
db.execute(sqlQuery)
