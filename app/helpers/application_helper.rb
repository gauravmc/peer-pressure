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
  
  def pygmented_code(language, code)
    Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'), {'lang'=>language, 'code'=>code}).body
  end
  
  def feedbox_code
    "<iframe src='#{root_url}feedbox/#{current_shop.id}' height='300px' width='240px' style='overflow-y:scroll; margin:0; padding:0; border:1px solid #{current_shop.feedbox.box_border};'></iframe>"
  end
end
