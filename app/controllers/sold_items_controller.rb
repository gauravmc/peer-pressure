class SoldItemsController < ApplicationController
  def fetch
    @items = SoldItem.where('shop_id = ? AND created_at > ?', params[:id], Time.now.utc).reverse
    respond_to do |format|
      format.json  { render json: {items: @items.as_json(include: [:product, :shop])} }
    end
  end
end
