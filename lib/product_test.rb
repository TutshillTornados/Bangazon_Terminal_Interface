#Author Daniel
require 'minitest/autorun'
require "sqlite3"
$:.unshift File.join(File.dirname(__FILE__), ".")
require 'controllers/product'


class ProductTest < Minitest::Test

    def setup
      @testProduct = Product.new(price:55.0, title:"test_product", description:"descibing bit", quantity:44)
      @testUser = $ACTIVE_CUSTOMER_ID = 11
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

    # def test_data_type_returned
    #     if 
            
    #     else
            
    #     end

    # end

    def test_returns_user_products
        assert_equal 11, @testUser
    end

    def test_returns_product_arrays
        assert_kind_of Array, Product.import_products
    end

end