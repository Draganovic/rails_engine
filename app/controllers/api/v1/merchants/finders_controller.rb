class Api::V1::Merchants::FindersController < ApplicationController
  respond_to :json

  def show
    respond_with find_merchants.first
  end

  def index
    respond_with find_merchants
  end

  private

    def build_query
      query = []
      query << "name ILIKE '#{merchant_name_params[:name]}'" if merchant_name_params[:name]
    end

    def merchant_params
      params.permit(:created_at, :id, :updated_at)
    end

    def merchant_name_params
      params.permit(:name)
    end

    def find_merchants
      merchants = Merchant.where(merchant_params)
      unless merchant_name_params.empty?
        merchants = merchants.where(build_query)
      end
      merchants
    end

end
