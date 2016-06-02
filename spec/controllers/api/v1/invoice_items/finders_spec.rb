require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::FindersController, type: :controller do
  describe "GET #show" do
    it "returns the one invoice_item with the given attribute" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)
      invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.25)
      invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 20.50)
      invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice2.id, quantity: 2, unit_price: 30.00)

      get :show, id: invoice_item1.id, format: :json

      expect(response.status).to eq(200)
      invoice_item =  JSON.parse(response.body)

      expect(2).to eq(invoice_item['quantity'])

      get :show, quantity: invoice_item2.quantity, format: :json
      invoice_itme2 =  JSON.parse(response.body)
      expect(5).to eq(invoice_itme2['id'])
    end
  end

  describe "GET #index" do
    it "returns all the invoice_items with the given attribute" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)
      invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 1025)
      invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 2050)
      invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice2.id, quantity: 2, unit_price: 3001)

      get :index, id: invoice_item3.id, format: :json
      expect(response.status).to eq(200)
      invoice_item =  JSON.parse(response.body)

      expect("30.01").to eq(invoice_item.first['unit_price'])
      get :index, quantity: 2, format: :json
      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)

      first_item = invoice_items.first
      last_item = invoice_items.last

      expect(response.status).to eq(200)
      expect(invoice_item1.id).to eq(first_item['id'])
      expect(invoice_item3.id).to eq(last_item['id'])
    end
  end
end
