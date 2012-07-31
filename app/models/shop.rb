class Shop < ActiveRecord::Base
  attr_accessible :domain, :name, :owner, :remote_id, :token
  has_many :products
  has_many :sold_items
end
