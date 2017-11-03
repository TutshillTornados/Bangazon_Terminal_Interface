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
        @testPayment = Payment.new(name:44, account:1234123412341234)
    end

    def test_initialize
        assert_raises ArgumentError do
            Payment.new
        end

        assert_raises ArgumentError do
            Payment.new("arg1")
        end

        assert_raises ArgumentError do
            Payment.new("arg1", "arg2")
        end

        @tp = Payment.new(1, 2)
        assert_equal 1, @tp.payment_name
        assert_equal 2, @tp.account_type

    
        unless @tp.payment_name.is_a?(String)
        else
            assert_raises ArgumentError do
            end
        end

    end


    def test_save_Payment
        p @testPayment
        @testPayment.save_payment
        # assert_equal true, worked
    end

end
