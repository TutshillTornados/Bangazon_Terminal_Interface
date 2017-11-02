#Authors Daniel and Austin 
#methods to test 
#save_customer
#add_using_questions
#initialize
require 'minitest/autorun'
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require_relative 'customer'
require_relative 'store'
require_relative 'dba'


class CustomerTest < Minitest::Test

    def setup
      @testCustomer = Customer.new(first_name:"Daniel", last_name:"Greene", street:"123 asdf", city:"asdf", state:"TN", zip: 234234, phone:1234567890)
    end

    def test_initialize
        assert_raises ArgumentError do
            Customer.new()
        end
        assert_instance_of Customer,
        @testCustomer
    end
    # def self.test_save_customer_setup
    #     args = {}
    #     @first_name = "Rob"
    #     @last_name = "Zombie"
    #     @street = "123 asdfasd"
    #     @city = "HELL"
    #     @state = "MI"
    #     @zip = 345645
    #     @phone = 123445675678
    #     return args
    # end
    def test_save_customer
        p @testCustomer
        @testCustomer.save_customer
        # assert_equal true, worked
    end
    # def customer_search_name
    #     assert_includes(Customer.customer_search_first_name("Rob"), @first_name5)
    # end
end