class HomeController < ApplicationController
  around_filter :shopify_session, except: [:welcome, :feedbox]
  layout 'box', only: [:feedbox]
  
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
      current_shop.create_feedbox
    end
    fetch_sold_items unless current_shop.sold_items.any?
  end
  
  def feedbox
    sold_items = SoldItem.order('created_at DESC').where(shop_id: params[:id])
    @items = sold_items.last(30)
    @offset = sold_items.count
    @shop = Shop.find(params[:id])
    @feedbox = @shop.feedbox
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
