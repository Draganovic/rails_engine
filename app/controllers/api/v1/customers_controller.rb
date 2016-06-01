class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    @customer = Customer.all
    respond_with :api, :v1, @customer
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end
end
