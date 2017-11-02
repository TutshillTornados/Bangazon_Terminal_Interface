#PAYMENT CONTROLLER 

require 'store'
class Customer

    attr_accessor :name, :account
    def initialize
        @name = args[:name]
        @account_number = args[:account]
    end

    def self.add_payment_option
        args = {}
        print "Enter payment type (e.g. AmEx, Visa, Checking)"
        args[:name] = gets.chomp.upcase.strip

        print "Enter account number"
        args[:account] = gets.chomp.upcase.strip
        return self.new(args)
    end

    def save_payment
        return false unless DatabaseAdmin.file_useable?
        db = SQLite3::Database.open("bangazon_store.sqlite")
        db.execute("INSERT INTO payments(name, account) VALUES(?, ?)", ["#{name}", "#{account}"])
        #Add active customerId to table
        db.close
        return true
    end

end