class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  respond_to :json

  def show
    frequencies = Customer.find(params[:id]).
                           invoices.joins(:transactions).
                           where(transactions: { result: "success"}).
                           group(:customer_id).count

    customer_id = frequencies.max_by { |k,v| v }.first

    respond_with Merchant.find(customer_id)
  end

end
