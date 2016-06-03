require 'rails_helper'

RSpec.describe Api::V1::Items::FindersController, type: :controller do

  xdescribe "GET #show" do
  xit "returns the one item with the given attribute" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )

      get :show, id: item1.id, format: :json

      expect(response.status).to eq(200)
      parsed_item1 =  JSON.parse(response.body)

      expect(item1.name).to eq(parsed_item1['name'])

      get :show, unit_price: item3.unit_price, format: :json
      parsed_item3 =  JSON.parse(response.body)

      expect(item3.name).to eq(parsed_item3['name'])
    end
  end

  xdescribe "GET #index" do
    xit "returns all the invoices with the given attribute" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
      item2 = Item.create(name: "Lamp", description: "Bringer of the light", unit_price: 10.25, merchant_id: merchant1.id )
      item3 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
      item4 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 20.50, merchant_id: merchant2.id )

      items = [item1, item2, item3, item4]

      get :index, unit_price: 10.25, format: :json
      expect(response.status).to eq(200)

      parsed_item = JSON.parse(response.body)

      expect(item1.id).to eq(parsed_item.first['id'])

      get :index, unit_price: 20.50, format: :json
      parsed_items = JSON.parse(response.body)

      expect(parsed_items.count).to eq(2)

      first_item = parsed_items.first
      last_item = parsed_items.last

      expect(response.status).to eq(200)
      expect(item3.id).to eq(first_item['id'])
      expect(item4.id).to eq(last_item['id'])
    end
  end
end
