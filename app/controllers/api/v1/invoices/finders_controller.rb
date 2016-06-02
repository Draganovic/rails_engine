class Api::V1::Invoices::FindersController < ApplicationController
  respond_to :json

  def show
    respond_with Invoice.find_by(invoice_params)
  end

  def index
    respond_with Invoice.where(invoice_params)
  end

  private
    def invoice_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
