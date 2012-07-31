module SessionHelper
  def self.current_shop
    Shop.find_by_remote_id ShopifyAPI::Shop.current.id
  end
end
