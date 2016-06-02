require 'rails_helper'

RSpec.describe Api::V1::Items::MerchantsController, type: :controller do

  describe "GET #show" do
    it "returns the merchant belonging to a item" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )

      get :show, id: item3.id, format: :json

      parsed_merchant = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(merchant2.id).to eq(parsed_merchant['id'])
    end
  end
end
