class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    @customer = Customer.all
    respond_with :api, :v1, @customer
  end
end
