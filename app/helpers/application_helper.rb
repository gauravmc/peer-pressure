module ApplicationHelper
  def webhooks_url
    "#{root_url}webhooks"
  end
  
  def shared_secret
    ShopifyApp.configuration.secret
  end
  
  def current_shop_present?
    Shop.where(remote_id: ShopifyAPI::Shop.current.id).present?
  end
  
  def current_shop
    @current_shop ||= ShopifyAPI::Shop.current
  end
end
