require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP PAYMENTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE payments"
db.execute(sqlQuery)
