class Api::V1::Transactions::RandomController < ApplicationController
  respond_to :json

  def show
    num = rand(Transaction.count)
    respond_with Transaction.offset(num).first
  end

end
