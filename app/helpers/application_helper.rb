module ApplicationHelper
  def webhooks_url
    "#{root_url}webhooks"
  end
  
  def shared_secret
    ShopifyApp.configuration.secret
  end
    
  def current_shop
    @current_shop ||= Shop.find_by_remote_id remote_shop.id
  end
  
  def remote_shop
    @remote_shop ||= ShopifyAPI::Shop.current
  end
  
  def json_decode(data)
    ActiveSupport::JSON.decode data
  end
end
