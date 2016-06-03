require 'rails_helper'

RSpec.describe Api::V1::Merchants::FavoriteCustomerController, type: :controller do

  describe "GET #index" do
    it "returns the favorite customer of a merchant" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      customer3= Customer.create(first_name: "Bill", last_name: "Billson")
      merchant = Merchant.create(name: "Beth")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant.id)
      invoice3 = Invoice.create(status: "shipped", customer_id: customer3.id, merchant_id: merchant.id)
      invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.25)
      invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 20.50)
      invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 30.00)
      transaction1 = Transaction.create(credit_card_number: "4654405418249632", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice2.id)
      transaction3 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice3.id)

      get :show, id: merchant.id, format: :json

      parsed_customer = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_customer['id']).to eq(customer1.id)
      expect(parsed_customer['first_name']).to eq(customer1.first_name)
    end
  end
end
