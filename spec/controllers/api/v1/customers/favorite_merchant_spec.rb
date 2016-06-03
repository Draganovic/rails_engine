require 'rails_helper'

RSpec.describe Api::V1::Customers::FavoriteMerchantController, type: :controller do

  describe "GET #index" do
    it "returns the favorite merchant of a customer" do
      customer = Customer.create(first_name: "Bob", last_name: "Dillan")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      merchant3 = Merchant.create(name: "Hans")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = Invoice.create(status: "shipped", customer_id: customer.id, merchant_id: merchant2.id)
      invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.25)
      invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 20.50)
      invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 30.00)
      transaction1 = Transaction.create(credit_card_number: "4654405418249632", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice2.id)
      transaction3 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice3.id)

      get :show, id: customer.id, format: :json

      parsed_merchant = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_merchant['id']).to eq(merchant1.id)
      expect(parsed_merchant['name']).to eq(merchant1.name)
    end
  end
end
