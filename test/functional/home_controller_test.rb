require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "loading index page the first time saves the shop and creates webhook" do
    shops(:gauravtesting).destroy
    ShopifyAPI::Webhook.expects(:create)
    assert_difference ['Shop.count', 'Feedbox.count'] do
      get :index
    end
  end
end
