require 'rails_helper'

RSpec.describe Api::V1::Invoices::FindersController, type: :controller do

  describe "GET #show" do
    it "returns the one invoice with the given attribute" do
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

      get :show, id: invoice1.id, format: :json

      expect(response.status).to eq(200)
      parsed_invoice1 =  JSON.parse(response.body)

      expect("shipped").to eq parsed_invoice1['status']

      get :show, status: invoice3.status, format: :json
      parsed_invoice3 =  JSON.parse(response.body)

      expect(invoice3.customer_id).to eq parsed_invoice3['customer_id']
    end
  end

  describe "GET #index" do
    it "returns all the invoices with the given attribute" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)
      invoice3 = Invoice.create(status: "failed", customer_id: customer1.id, merchant_id: merchant2.id)
      invoice4 = Invoice.create(status: "failed", customer_id: customer1.id, merchant_id: merchant1.id)

      invoices = [invoice1, invoice2, invoice3]

      get :index, status: "shipped", format: :json
      expect(response.status).to eq(200)

      parsed_invoice = JSON.parse(response.body)

      expect(invoice1.id).to eq(parsed_invoice.first['id'])

      get :index, status: "failed", format: :json
      parsed_invoices = JSON.parse(response.body)

      expect(parsed_invoices.count).to eq(2)

      first_inv = parsed_invoices.first
      last_inv = parsed_invoices.last

      expect(response.status).to eq(200)
      expect(invoice3.id).to eq(first_inv['id'])
      expect(invoice4.id).to eq(last_inv['id'])
    end
  end
end
