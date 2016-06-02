require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :controller do

  describe "GET #index" do
    it "returns all the items belonging to the merchant" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Bill")

      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )

      get :index, id: merchant1.id, format: :json

      parsed_items = JSON.parse(response.body)
      first_item = parsed_items.first
      last_item = parsed_items.last

      expect(response.status).to eq(200)
      expect(parsed_items.count).to eq(2)
      expect(item1.id).to eq(first_item['id'])
      expect(item2.id).to eq(last_item['id'])
    end
  end
end
