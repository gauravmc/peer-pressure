class Shop < ActiveRecord::Base
  attr_accessible :domain, :name, :owner, :remote_id, :token
  has_many :products
  has_many :sold_items
  has_one :feedbox
  
  def webhook_exists?(topic)
    return true unless ShopifyAPI::Webhook.find(:all, params: { topic: topic }).empty?
  end
end
