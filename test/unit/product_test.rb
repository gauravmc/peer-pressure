require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @order_create_data = load_json('order_create.json')
  end
  
  test "product gets saved from webhook json data" do
    assert_difference 'Product.count', 2 do
      Product.fetch_new_products_from(@order_create_data)
    end
  end
end
