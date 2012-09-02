class Shop < ActiveRecord::Base
  attr_accessible :domain, :name, :owner, :remote_id, :token
  has_many :products, dependent: :destroy
  has_many :sold_items, dependent: :destroy
  has_one :feedbox, dependent: :destroy
  
  default_scope where('remote_id IS NOT NULL')
  
  def webhook_exists?(topic)
    return true unless ShopifyAPI::Webhook.find(:all, params: { topic: topic }).empty?
  end
  
  def destroy
    run_callbacks :destroy do
      self.remote_id = nil
      save
    end
  end
end
