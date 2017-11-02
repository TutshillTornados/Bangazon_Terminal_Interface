require 'faker'
require 'sqlite3'

    db = SQLite3::Database.open("bangazon_store.sqlite")

    ######### SEED CUSTOMERS #########
    50.times do
        db.execute("INSERT INTO customers(first_name, last_name, street, city, state, zip, phone) VALUES(?, ?, ?, ?, ?, ?, ?)", ["#{Faker::Name.first_name}", "#{Faker::Name.last_name}", "#{Faker::Address.street_address}", "#{Faker::Address.city}", "#{Faker::Address.state_abbr}", "#{Faker::Address.zip_code}", "#{Faker::PhoneNumber.phone_number}"])
    end

    ######### SEED ACCOUNTS #########
    20.times do
        db.execute("INSERT INTO payments(customer_id, account, name) VALUES(?, ?, ?)", ["#{Faker::Number.between(1, 50)}", "#{Faker::Number.number(16)}", "VISA"])
    end
    20.times do
        db.execute("INSERT INTO payments(customer_id, account, name) VALUES(?, ?, ?)", ["#{Faker::Number.between(1, 50)}", "#{Faker::Number.number(16)}", "MC"])
    end
    20.times do
        db.execute("INSERT INTO payments(customer_id, account, name) VALUES(?, ?, ?)", ["#{Faker::Number.between(1, 50)}", "#{Faker::Number.number(16)}", "AMEX"])
    end
    20.times do
        db.execute("INSERT INTO payments(customer_id, account, name) VALUES(?, ?, ?)", ["#{Faker::Number.between(1, 50)}", "#{Faker::Number.number(16)}", "BANK"])
    end

    ######### SEED PRODUCT #########
    200.times do
        db.execute("INSERT INTO products(price, title, description, quantity, date_added, seller_id) VALUES(?, ?, ?, ?, ?, ?)", ["#{Faker::Number.decimal(2)}", "#{Faker::Coffee.blend_name}", "#{Faker::Coffee.notes}", "#{Faker::Number.between(1, 50)}", "#{Faker::Date.backward(200)}", "#{Faker::Number.between(1, 50)}"])
    end

    ######### SEED ORDERS #########
    200.times do
        db.execute("INSERT INTO orders(total, payment_id, customer_id) VALUES(?, ?, ?)", ["#{Faker::Number.decimal(2)}", "#{Faker::Number.between(1, 80)}", "#{Faker::Number.between(1, 50)}"])
    end

    ######### SEED ORDER-PRODUCTS #########
    400.times do
        db.execute("INSERT INTO order_products(price, seller_id, order_id, product_id) VALUES(?, ?, ?, ?)", ["#{Faker::Number.decimal(2)}", "#{Faker::Number.between(1, 50)}", "#{Faker::Number.between(1, 200)}", "#{Faker::Number.between(1, 200)}"])
    end
    
    db.close
