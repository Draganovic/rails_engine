class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    @transaction = Transaction.all
    respond_with :api, :v1, @transaction
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

end
