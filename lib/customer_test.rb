#Authors Daniel and Austin 
#methods to test 
#save_customer
#add_using_questions
#initialize
require 'minitest/autorun'
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require_relative 'customer'


class CustomerTest < Minitest::Test

    def setup
      @testCustomer = Customer.new(first_name:"MEHEHEHEHE", last_name:"BLAH", street:"1qwerqwrqwe", city:"asqweqweqwedf", state:"TqweqweqweN", zip: 23423234234324, phone:1234562342342347890)
    end

    def test_initialize
        assert_raises ArgumentError do
            Customer.new()
        end
        assert_instance_of Customer,
        @testCustomer
    end

    ##REMOVE DATABASE CONDITIONS ON SAVE_CUSTOMER FOR TEST TO WORK
    def test_save_customer
        p @testCustomer
        @testCustomer.save_customer
        # assert_equal true, worked
    end

end