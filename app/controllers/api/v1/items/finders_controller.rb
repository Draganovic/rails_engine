class Api::V1::Items::FindersController < ApplicationController
  respond_to :json

  def show
    if item_params[:created_at] || item_params[:updated_at]
      item = Item.where(item_params)
      respond_with item.first
    else
    respond_with Item.find_by(item_params)
    end
  end

  def index
    respond_with Item.where(item_params)
  end

  private

    def item_params
      params.permit(:name, :id, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end
