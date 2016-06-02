require 'rails_helper'

RSpec.describe Api::V1::Transactions::FindersController, type: :controller do

  describe "GET #show" do
    it "returns the one transaction with the given attribute" do
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
      transaction1 = Transaction.create(credit_card_number: "4654405418249632", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create(credit_card_number: "4654405418249444", result: "canceled", invoice_id: invoice2.id)
      transaction3 = Transaction.create(credit_card_number: "4654405418249444", result: "other", invoice_id: invoice2.id)

      get :show, id: transaction1.id, format: :json

      expect(response.status).to eq(200)
      parsed_transaction1 = JSON.parse(response.body)

      expect(transaction1.result).to eq(parsed_transaction1['result'])

      get :show, result: transaction3.result, format: :json
      parsed_transaction3 = JSON.parse(response.body)

      expect(transaction3.id).to eq(parsed_transaction3['id'])
    end
  end

  describe "GET #index" do
    it "returns all the transactions with the given attribute" do
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
      transaction1 = Transaction.create(credit_card_number: "4654405418249632", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create(credit_card_number: "4654405418249444", result: "success", invoice_id: invoice2.id)
      transaction3 = Transaction.create(credit_card_number: "4654405418249444", result: "canceled", invoice_id: invoice2.id)

      transactions = [transaction1, transaction2, transaction3]

      get :index, result: "canceled", format: :json
      expect(response.status).to eq(200)

      parsed_transaction = JSON.parse(response.body)

      expect(transaction3.id).to eq(parsed_transaction.first['id'])

      get :index, result: "success", format: :json
      parsed_transactions = JSON.parse(response.body)

      expect(parsed_transactions.count).to eq(2)

      first_transaction = parsed_transactions.first
      last_transaction = parsed_transactions.last

      expect(response.status).to eq(200)
      expect(transaction1.id).to eq(first_transaction['id'])
      expect(transaction2.id).to eq(last_transaction['id'])
    end
  end
end
