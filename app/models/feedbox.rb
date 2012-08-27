class Feedbox < ActiveRecord::Base
  attr_accessible :box_background, :box_border, :item_background, :item_border, :font_size, :image_size,
                  :box_width, :box_height, :scrollbar, :shadow, :shop_id
  belongs_to :shop
  
  SIZES = {
    font_size: {min: '11', max: '20', unit: 'px'},
    image_size: {min: '30', max: '50', unit: '%'},
    box_width: {min: '200', max: '300', unit: 'px'},
    box_height: {min: '250', max: '350', unit: 'px'},
  }
  
  def scrollbar_css
    scrollbar? ? 'yes' : 'no'  
  end
  
  def shadow_css
    if shadow?
      '-moz-box-shadow: 1px 1px 4px #d0d0d0; -webkit-box-shadow: 1px 1px 4px #d0d0d0; box-shadow: 1px 1px 4px #d0d0d0;'
    else
      ''
    end
  end
    
  def reset
    self.box_background = '#f5f5f5'
    self.box_border = '#d0d0d0'
    self.item_background = '#ffffff'
    self.item_border = '#d0d0d0'
    self.font_size = '11px'
    self.image_size = '30%'
    self.box_width = '240px'
    self.box_height = '300px'
    self.scrollbar = 0
    self.shadow = 0
  end
  
  def reset!
    reset
    save!
  end

  before_save :load_default_values

  private
  
  def load_default_values
    reset if new_record?
  end
end
