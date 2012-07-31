class HomeController < ApplicationController
  around_filter :shopify_session, :except => 'welcome'
  layout 'ticker_box', only: [:ticker]
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
    unless current_shop.present?
      Shop.create(
        domain: remote_shop.myshopify_domain,
        name: remote_shop.name,
        owner: remote_shop.shop_owner,
        token: shop_session.token,
        remote_id: remote_shop.id
      )
      create_webhooks
    end
  end
  
  def ticker
    @items = SoldItem.where(shop_id: params[:id], status: 'pushed').last(50).reverse
  end
  
  def create_webhooks
    ShopifyAPI::Webhook.create(topic: 'orders/create', address: "#{webhooks_url}/order/create", format: 'json')
  end
end
