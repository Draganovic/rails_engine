class Api::V1::Items::MostItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.most_items(params[:quantity])
  end
end
