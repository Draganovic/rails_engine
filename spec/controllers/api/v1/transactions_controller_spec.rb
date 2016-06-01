require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  def setup
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
  end
  it "should get all the transactions" do
    setup
    get :index, format: :json

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq 2
  end

  it "can view one transaction" do
    setup

    id = Transaction.last.id

    get "show", id: id, format: :json

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq id
  end
end
