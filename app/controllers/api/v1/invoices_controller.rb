class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    @invoice = Invoice.all
    respond_with :api, :v1, @invoice
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

end
