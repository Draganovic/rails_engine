class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    @merchant = Merchant.all
    respond_with :api, :v1, @merchant
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

end
