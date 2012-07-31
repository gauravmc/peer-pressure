class SoldItemsController < ApplicationController
  def fetch
    @items = SoldItem.where(shop_id: params[:id]).offset(params[:offset]).reverse
    respond_to do |format|
      format.json  { render json: {items: @items.as_json(include: [:product, :shop])} }
    end
  end
  
  def update
    item = SoldItem.find(params[:id])
    item.update_attributes(params[:item])
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
