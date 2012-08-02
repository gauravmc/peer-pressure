require 'test_helper'

class SoldItemsControllerTest < ActionController::TestCase
  setup do
    @shop = shops(:gauravtesting)
  end
  
  test "fetch returns sold items data" do
    get :fetch, id: @shop.id, offset: 10, format: :json
    
    assert response_body.has_key? 'items'
  end
  
  test "fetch returns only newly created sold items" do
    offset = @shop.sold_items.count
    item = @shop.sold_items.create(product_id: 1, quantity: 1)
    
    get :fetch, id: @shop.id, offset: offset, format: :json
    
    assert_equal 1, response_body['items'].count
    assert_equal item.id, response_body['items'].pop['id']
  end
end
