class SoldItem < ActiveRecord::Base
  attr_accessible :product_id, :shop_id, :quantity, :shop, :product
  belongs_to :shop
  belongs_to :product
  
  def self.fetch_new_items_from(data)
    data['line_items'].each do |line_item|
      SoldItem.create(
        product_id: line_item['product_id'],
        quantity: line_item['quantity'],
        shop_id: ShopifyAPI::Shop.current.id
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
