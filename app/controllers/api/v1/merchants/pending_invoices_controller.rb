class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  respond_to :json

  def index
    result = Merchant.find(params[:id]).
                      invoices.joins(:transactions).
                      where(transactions: { result: "failed" }).
                      group(:customer_id).count

    customers = result.map do |cust_id|
      Customer.find(cust_id.first)
    end
    respond_with customers
  end

end
