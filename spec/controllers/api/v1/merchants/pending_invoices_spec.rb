require 'rails_helper'

RSpec.describe Api::V1::Merchants::PendingInvoicesController, type: :controller do

  describe "GET #index" do
    it "returns the all customers with pending invoices for a given merchant" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      customer3= Customer.create(first_name: "Bill", last_name: "Billson")

      merchant = Merchant.create(name: "Beth")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant.id )
      invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant.id)
      invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant.id)
      invoice3 = Invoice.create(status: "shipped", customer_id: customer3.id, merchant_id: merchant.id)
      invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.25)
      invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 20.50)
      invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 30.00)
      transaction1 = Transaction.create(credit_card_number: "4654405418249632", result: "failed", invoice_id: invoice1.id)
      transaction2 = Transaction.create(credit_card_number: "4654405418249444", result: "failed", invoice_id: invoice2.id)
      transaction3 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice3.id)

      # customer1, customer2, customer3 = create_list(:customer, 3)
      # merchant = create(:merchant)
      # invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      # invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      # invoice3 = create(:invoice, customer_id: customer3.id, merchant_id: merchant.id)
      # transaction1 = create(:transaction, invoice_id: invoice1.id, result: "failed")
      # transaction2 = create(:transaction, invoice_id: invoice2.id, result: "failed")
      # transaction3 = create(:transaction, invoice_id: invoice3.id, result: "success")

      get :index, id: merchant.id, format: :json

      parsed_customers = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_customers.count).to eq(2)
      expect(parsed_customers.first['id']).to eq(customer1.id)
      expect(parsed_customers.last['id']).to eq(customer2.id)
    end
  end
end
