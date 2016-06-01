class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    @item = Item.all
    respond_with :api, :v1, @item
  end
end
