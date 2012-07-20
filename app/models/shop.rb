class Shop < ActiveRecord::Base
  attr_accessible :domain, :name, :owner, :remote_id, :token
end
