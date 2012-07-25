class SoldItem < ActiveRecord::Base
  attr_accessible :product_id, :shop_id, :quantity
  belongs_to :shop
  belongs_to :product
end
