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
    session = ShopifyAPI::Session.new('gauravtesting.myshopify.com', 'c4d48141fee20750f6b4b2d9fa09fdc5')
    ShopifyAPI::Base.activate_session session
  end

  # Add more helper methods to be used by all tests here...
  
  def load_json(filename)
    JSON.parse File.read(Rails.root.join('test/fixtures/json', filename))
  end
end
