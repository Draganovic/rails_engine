require 'rails_helper'

RSpec.describe Api::V1::Invoices::CustomersController, type: :controller do

  describe "GET #show" do
    it "returns the customer belonging to a invoice" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)
      invoice3 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant2.id)

      get :show, id: invoice3.id, format: :json

      parsed_customer = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(customer1.id).to eq(parsed_customer['id'])
    end
  end
end
