require 'test_helper'

class WebhooksControllerTest < ActionController::TestCase
  setup do
    @order_create_data = load_json('order_create.json')
    WebhooksController.any_instance.stubs(:verify_webhook).returns(true)
  end
  
  test "order/create webhook request" do
    WebhooksController.any_instance.stubs(:decoded_request_data).returns(@order_create_data)

    assert_difference 'Product.count', 2 do
      post :order_created
    end
  end
end
