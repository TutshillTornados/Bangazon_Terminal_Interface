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
        @testPayment = Payment.new(card_name:"AMEXs", account:1234123412341234)
        # Payment.new(name:"VISA")
    end

    def test_initialize
        assert_raises ArgumentError do
            Payment.new()
        end
        assert_instance_of Payment,
        @testPayment
    end

    def test_save_Payment
        # print @testPayment
        @testPayment.save_payment
        # assert_equal true, worked
    end

    # puts @testPayment

    def test_customer_input_equals_accepted_payment_methods
        assert (@testPayment.card_name == "VISA" || @testPayment.card_name == "AMEX" || @testPayment.card_name == "BANK" || @testPayment.card_name == "MC")
    end

    def test_payment_type_gets_correct_account_int
        assert_equal 16, @testPayment.account.to_s.length
    end

end
