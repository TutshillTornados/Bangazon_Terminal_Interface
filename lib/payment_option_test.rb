#PAYMENT TYPE TEST
# Author: Matt Minner
# Testing to see if payment can be added to database.
# -- methods to test --
#save_payment
#add_payment_option
#initialize
require 'minitest/autorun'
require "sqlite3"

$:.unshift File.join(File.dirname(__FILE__), ".")
require 'controllers/payment_option'

class PaymentTest < Minitest::Test
    def setup
        @testPayment = Payment.new(name:"VISAH", account:1234123412341234)
    end

    def test_initialize
        assert_raises ArgumentError do
            Payment.new()
        end
        assert_instance_of Payment,
        @testPayment
    end

    def test_save_Payment
        p @testPayment
        @testPayment.save_payment
        # assert_equal true, worked
    end
end
