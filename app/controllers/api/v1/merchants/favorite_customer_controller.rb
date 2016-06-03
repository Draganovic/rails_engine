class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  respond_to :json

  def show
    frequencies = Merchant.find(params[:id]).
                           invoices.joins(:transactions).
                           where(transactions: { result: "success"}).
                           group(:customer_id).count

    merchant_id = frequencies.max_by { |k,v| v }.first

    respond_with Customer.find(merchant_id)
  end

end
