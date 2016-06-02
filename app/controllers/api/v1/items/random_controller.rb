class Api::V1::Items::RandomController < ApplicationController
  respond_to :json

  def show
    respond_with Item.new.random
  end
end
