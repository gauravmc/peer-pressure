class Product < ActiveRecord::Base
  attr_accessible :img_url, :remote_id, :shop_id, :title, :shop, :handle
  belongs_to :shop
  has_many :sold_items
  include SessionHelper
  
  def self.fetch_new_products_from(data)
    data['line_items'].each do |line_item|
      unless Product.find_by_remote_id(line_item['product_id'])
        remote_product = ShopifyAPI::Product.find(line_item['product_id'])
        product = Product.new(
          remote_id: remote_product.id,
          title: remote_product.title,
          handle: remote_product.handle,
          shop_id: SessionHelper.current_shop.id
        )
        product.img_url = remote_product.images.any? ? remote_product.images.first.src : ''
        product.save
      end
    end
  end
  
  def img_url
    '/assets/shopify-small.png' unless super.present?
  end
  
  def remote_find(id)
    ShopifyAPI::Product.find(id)
  end
end
