class Feedbox < ActiveRecord::Base
  attr_accessible :box_background, :box_border, :item_background, :item_border, :shop_id
  belongs_to :shop
  
  before_save :load_default_values
  
  private
  
  def load_default_values
    if new_record?
      self.box_background = '#f5f5f5'
      self.box_border = '#d0d0d0'
      self.item_background = '#ffffff'
      self.item_border = '#d0d0d0'
    end
  end
end
