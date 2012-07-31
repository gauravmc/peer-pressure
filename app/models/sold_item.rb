class SoldItem < ActiveRecord::Base
  attr_accessible :product_id, :shop_id, :quantity, :shop, :product, :status
  belongs_to :shop
  belongs_to :product
  include SessionHelper
  
  def self.fetch_new_items_from(data)
    data['line_items'].each do |line_item|
      remote_product = ShopifyAPI::Product.find(line_item['product_id'])
      SoldItem.create(
        product_id: remote_product.id,
        quantity: line_item['quantity'],
        status: 'pending',
        shop_id: SessionHelper.current_shop.id
      )
    end
  end
  
  def message
    if quantity == 1
      "a #{product.title} was sold"
    else
      "#{quantity} units of #{product.title} were sold"
    end
  end
end
