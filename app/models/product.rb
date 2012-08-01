class Product < ActiveRecord::Base
  attr_accessible :img_url, :remote_id, :shop_id, :title, :shop, :handle
  belongs_to :shop
  has_many :sold_items
  include ApplicationHelper
  
  def self.fetch_from_order_json(data)
    data['line_items'].each do |item|
      unless Product.find_by_remote_id(item['product_id'])
        Product.new.save_from_line_item(item)
      end
    end
  end
  
  def save_from_line_item(item)
    remote_product = ShopifyAPI::Product.find(item['product_id'])
    update_attributes(
      remote_id: remote_product.id,
      title: remote_product.title,
      handle: remote_product.handle,
      shop_id: current_shop.id,
      img_url: remote_product.images.any? ? remote_product.images.first.src : ''
    )
    self
  end
  
  def img_url
    if super.present?
      super
    else
      "/assets/shopify-small.png"
    end
  end
  
  def remote_find(id)
    ShopifyAPI::Product.find(id)
  end
end
