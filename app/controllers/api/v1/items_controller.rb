class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    @item = Item.all
    respond_with :api, :v1, @item
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def create
    respond_with Item.create(item_params), location: nil
  end

  def update
    respond_with Item.update(params[:id], item_params)
  end

  def destroy
    respond_with Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
