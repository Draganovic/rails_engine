require 'rails_helper'

RSpec.describe Api::V1::Customers::InvoicesController, type: :controller do

  describe "GET #index" do
    it "returns all the invoices belonging to a customer" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)
      invoice3 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant1.id)

      invoices = [invoice1, invoice2, invoice3]

      get :index, id: customer2.id, format: :json

      parsed_invoices = JSON.parse(response.body)
      first_inv = parsed_invoices.first
      last_inv = parsed_invoices.last

      expect(response.status).to eq(200)
      expect(parsed_invoices.count).to eq(2)
      expect(invoice2.id).to eq(first_inv['id'])
      expect(invoice3.id).to eq(last_inv['id'])
    end
  end
end
