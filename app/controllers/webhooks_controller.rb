class WebhooksController < ApplicationController
  before_filter :verify_webhook
  
  def order_created
    Product.fetch_new_products_from(decoded_request_data)
    SoldItem.fetch_new_items_from(decoded_request_data)
    head :ok
  end
  
  private
  
  def verify_webhook
    data = request.raw_post
    hmac_header = request.env['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, shared_secret, data)).strip
    head :unauthorized unless calculated_hmac == hmac_header
  end
  
  def decoded_request_data
    ActiveSupport::JSON.decode request.body.read
  end
end
