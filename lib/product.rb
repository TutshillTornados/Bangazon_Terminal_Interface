#PRODUCT CONTROLLER 

require 'store'
class Product
    attr_accessor :price, :title, :description, :quantity
    
    def initialize
        @price = args[:price]
        @title = args[:title]
        @description = args[:description]
        @quantity = args[:quantity]
    end

    def add_product
        args = {}
        print "What is the price of the product? "
        args[:price] = gets.chomp.upcase.strip

        print "What is the title of the product? "
        args[:title] = gets.chomp.upcase.strip
        
        print "What is the description of the product? "
        args[:description] = gets.chomp.upcase.strip

        print "What is the quantity of the product? "
        args[:quantity] = gets.chomp.upcase.strip
        return self.new(args)
    end

    def save_product
        return false unless DatabaseAdmin.file_useable?
        db = SQLite3::Database.open("bangazon_store.sqlite")
        db.execute("INSERT INTO products(price, title, description, quantity) VALUES(?, ?, ?, ?)", ["#{price}", "#{title}", "#{description}", "#{quantity}"])
        #Add active customerId as SellerId to table
        #Add current date to date_added on table
        db.close
        return true
    end

    def import_products
    end

    def remove_product
    end

    def update_product
    end

end