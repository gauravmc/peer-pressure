class FeedboxesController < ApplicationController
  around_filter :shopify_session
  
  def edit
    @feedbox = Feedbox.find(params[:id])
  end
  
  def update
    @feedbox = Feedbox.find(params[:id])
    @feedbox.update_attributes(params[:feedbox])
    redirect_to edit_feedbox_path(@feedbox)
  end
end
