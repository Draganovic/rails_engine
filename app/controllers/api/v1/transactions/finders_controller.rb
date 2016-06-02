class Api::V1::Transactions::FindersController < ApplicationController
  respond_to :json

  def show
    respond_with find_transactions.first
  end

  def index
    respond_with find_transactions
  end

  private

    def build_query
      query = []
      query << "result ILIKE '#{transaction_name_params[:result]}'" if transaction_name_params[:result]
    end

    def transaction_params
      params.permit(:id, :invoice_id, :credit_card_number, :created_at, :updated_at)
    end

    def transaction_name_params
      params.permit(:result)
    end

    def find_transactions
      transactions = Transaction.where(transaction_params)
      unless transaction_name_params.empty?
        transactions = transactions.where(build_query)
      end
      transactions
    end
end
