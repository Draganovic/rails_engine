class Api::V1::InvoiceItems::FindersController < ApplicationController
  respond_to :json

  def index
    if invoice_item_params[:unit_price]
      unit_price = (invoice_item_params[:unit_price].to_f * 100).to_i
      respond_with InvoiceItem.where(unit_price: unit_price)
    else
      respond_with InvoiceItem.where(invoice_item_params)
    end
  end

  def show
    if invoice_item_params[:unit_price]
      unit_price = (invoice_item_params[:unit_price].to_f * 100).to_i
      invoice_items = InvoiceItem.where(unit_price: unit_price)
      respond_with invoice_items.first
    else
    invoice_items = InvoiceItem.where(invoice_item_params)
    respond_with invoice_items.first
  end
end

  private

    def invoice_item_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
    end

end
