#Author Daniel
require 'minitest/autorun'
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require 'controllers/product'


class ProductTest < Minitest::Test

    def setup
      @testProduct = Product.new(price:55.0, title:"test_product", description:"descibing bit", quantity:44)
    end

    #TESTING INITIALIZATION
    def test_initialize
        assert_raises ArgumentError do
            Product.new()
        end
        assert_instance_of Product,
        @testProduct
    end

    #TESTING WHAT IS BEING SAVED
    def test_save_product
        p @testProduct
        @testProduct.save_product
    end

    def test_data_type_returned
        if 
            
        else
            
        end

    end

end