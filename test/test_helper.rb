ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  def setup
    sess = ShopifyAPI::Session.new('gauravtesting.myshopify.com', 'd3ccce300db8049fcdab058689a27a52')
    session[:shopify] = sess if defined? session
    ShopifyAPI::Base.activate_session sess
  end

  # Add more helper methods to be used by all tests here...
  
  def load_json(filename)
    JSON.parse File.read(Rails.root.join('test/fixtures/json', filename))
  end
  
  def response_body
    JSON.parse response.body
  end
end
