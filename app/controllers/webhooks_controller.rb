class WebhooksController < ApplicationController
  before_filter :verify_webhook
  
  def order_created
    Product.fetch_from_order_json(decoded_request_data)
    SoldItem.fetch_from_order_json(decoded_request_data)
    head :ok
  end
  
  def app_uninstalled
    shop = Shop.find_by_remote_id(decoded_request_data['id'])
    shop.destroy
    head :ok
  end
  
  private
  
  def verify_webhook
    data = request.raw_post
    hmac_header = request.env['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, shared_secret, data)).strip
    if calculated_hmac == hmac_header
      connect
    else
      head :unauthorized
    end
  end
  
  def connect
    shop = Shop.find_by_domain(request.env['HTTP_X_SHOPIFY_SHOP_DOMAIN'])
    session = ShopifyAPI::Session.new(shop.domain, shop.token)
    ShopifyAPI::Base.activate_session session
  end
  
  def decoded_request_data
    ActiveSupport::JSON.decode request.body.read
  end
end
