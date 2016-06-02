class Api::V1::Customers::RandomController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.new.random
  end

end
