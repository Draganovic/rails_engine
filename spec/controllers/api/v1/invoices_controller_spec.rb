require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  it "should get all the invoices" do
    customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
    customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
    item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
    item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )
    invoice1 = Invoice.create(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create(status: "shipped", customer_id: customer2.id, merchant_id: merchant2.id)

    get :index, format: :json

    invoices = JSON.parse(response.body)
    
    expect(invoices.count).to eq 2
    expect(invoices.first["status"]).to eq "shipped"
  end
end
