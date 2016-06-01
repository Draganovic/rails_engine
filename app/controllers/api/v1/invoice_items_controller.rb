class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    @invoice_item = InvoiceItem.all
    respond_with :api, :v1, @invoice_item
  end
end
