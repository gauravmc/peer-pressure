class HomeController < ApplicationController
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
    unless current_shop_present?
      Shop.create(
        domain: current_shop.myshopify_domain,
        name: current_shop.name,
        owner: current_shop.shop_owner,
        token: shop_session.token,
        remote_id: current_shop.id
      )
      create_webhooks
    end
  end
  
  def create_webhooks
    ShopifyAPI::Webhook.create(topic: 'orders/create', address: "#{webhooks_url}/order/create", format: 'json')
  end
end
