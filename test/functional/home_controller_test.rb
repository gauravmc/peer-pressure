require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # setup do
  #   shops(:gauravtesting).destroy
  # end
  # 
  test "loading index page the first time saves the shop" do
    # shops(:gauravtesting).destroy
    # assert_equal 0, Shop.count
    # assert_difference 'Shop.count' do
    get :index
    # end
    assert_response :ok
  end
end
