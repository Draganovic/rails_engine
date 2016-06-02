require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::RandomController, type: :controller do

  describe "GET #show" do
    it "returns a random invoice_item" do
      customer1 = InvoiceItem.create(quantity: 5, unit_price: 7)
      customer2 = InvoiceItem.create(quantity: 6, unit_price: 8)

      get :show, format: :json

      expect(response.status).to eq(200)
      invoice = JSON.parse(response.body)
    end
  end

end
