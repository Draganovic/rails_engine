class Api::V1::Items::HighestSalesDateController < ApplicationController
  respond_to :json

  def show
    item = Item.find(params[:id])
    respond_with best_day: item.best_day
  end
end
