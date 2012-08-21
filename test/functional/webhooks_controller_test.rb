require 'test_helper'

class WebhooksControllerTest < ActionController::TestCase
  setup do
    @order_create_data = load_json('order_create.json')
    WebhooksController.any_instance.stubs(:verify_webhook).returns(true)
    WebhooksController.any_instance.stubs(:decoded_request_data).returns(@order_create_data)
  end
  
  test "order/create webhook request" do
    assert_difference ['Product.count','SoldItem.count'], 2 do
      post :order_created
    end
  end
  
  test "app/uninstalled webhook request" do
    post :app_uninstalled
    assert_equal 0, Product.count
    assert_equal 0, SoldItem.count
  end  
end
