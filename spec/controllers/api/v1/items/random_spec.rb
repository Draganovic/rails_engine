require 'rails_helper'

RSpec.describe Api::V1::Items::RandomController, type: :controller do

  describe "GET #show" do
    it "returns a random item" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )

      get :show, format: :json

      expect(response.status).to eq(200)
      item = JSON.parse(response.body)
    end
  end

end
