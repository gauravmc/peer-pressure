class HomeController < ApplicationController
  around_filter :shopify_session, :except => 'welcome'
  layout 'ticker_box', only: [:ticker]
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
    unless Shop.find_by_remote_id(remote_shop.id)
      Shop.create(
        domain: remote_shop.myshopify_domain,
        name: remote_shop.name,
        owner: remote_shop.shop_owner,
        token: shop_session.token,
        remote_id: remote_shop.id
      )
      create_webhooks
    end
    fetch_sold_items unless current_shop.sold_items.any?
  end
  
  def ticker
    sold_items = SoldItem.order('created_at DESC').where(shop_id: params[:id])
    @items = sold_items.last(30)
    @offset = sold_items.count
  end
  
  private
  
  def create_webhooks
    ShopifyAPI::Webhook.create(topic: 'orders/create', address: "#{webhooks_url}/order/create", format: 'json')
  end
  
  def fetch_sold_items
    orders = ShopifyAPI::Order.all.first 5
    orders.each do |order|
      SoldItem.fetch_from_order_json json_decode(order.to_json)
    end
  end
end
