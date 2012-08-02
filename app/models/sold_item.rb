class SoldItem < ActiveRecord::Base
  attr_accessible :product_id, :shop_id, :quantity, :shop, :product, :created_at
  belongs_to :shop
  belongs_to :product
  
  def self.fetch_from_order_json(data)
    data['line_items'].each do |item|
      product = Product.find_by_remote_id(item['product_id'])
      if product.nil?
        product = Product.new.save_from_line_item(item)
      end
      SoldItem.create(
        product_id: product.id,
        quantity: item['quantity'],
        shop_id: product.shop_id,
        created_at: data['created_at']
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
