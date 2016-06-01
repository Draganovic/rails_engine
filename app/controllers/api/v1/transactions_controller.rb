class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    @transaction = Transaction.all
    respond_with :api, :v1, @transaction
  end


end
