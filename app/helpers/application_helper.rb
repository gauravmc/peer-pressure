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
    
  def feedbox_code
    "<iframe src='#{root_url}feedbox/#{current_shop.id}' height='#{current_shop.feedbox.box_height}' width='#{current_shop.feedbox.box_width}' scrolling='#{current_shop.feedbox.scrollbar_css}' style='overflow-y:scroll; margin:0; padding:0; border:1px solid #{current_shop.feedbox.box_border}; #{current_shop.feedbox.shadow_css}'></iframe>"
  end
end
