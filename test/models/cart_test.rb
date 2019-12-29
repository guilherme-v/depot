require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'should be able to add a product' do
    cart = Cart.new
    cart.add_product(products(:ruby))
    cart.save!

    assert_equal cart.line_items.count, 1
  end

  test 'should not add same product twice' do
    cart = Cart.new
    cart.add_product(products(:ruby))
    cart.save!
    cart.add_product(products(:ruby))
    cart.save!

    assert_equal cart.line_items.count, 1
  end
end
