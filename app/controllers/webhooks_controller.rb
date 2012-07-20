class WebhooksController < ApplicationController
  before_filter :verify_webhook
  
  def order_created
    data = ActiveSupport::JSON.decode(request.body.read)
    data['line_items'].each do |product|
      # puts "#{product['title']} was sold just now!"
    end
    head :ok
  end
  
  private
  
  def verify_webhook
    data = request.raw_post
    hmac_header = request.env['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, shared_secret, data)).strip
    calculated_hmac == hmac_header
  end
end
