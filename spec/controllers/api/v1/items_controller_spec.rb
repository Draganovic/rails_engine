require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  it "should get all the items" do
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
    item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )
    item3 = Item.create(name: "Shovel", description: "Digs holes", unit_price: 30.00, merchant_id: merchant2.id )

    get :index, format: :json

    items = JSON.parse(response.body)

    expect(items.count).to eq 3
    expect(items.first["name"]).to eq "Soap"
  end

  it "can view one item" do
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
    item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )

    id = Item.last.id

    get "show", id: id, format: :json

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq id
  end

  it "can create a new item" do
    item_params = { name: "Screwdriver", description: "It's mostly used for poking holes", unit_price: 22.22}

    post "create", item: item_params, format: :json

    expect(response).to be_success

    new_item = Item.last

    expect(new_item.name).to eq "Screwdriver"
  end

  it "can update an item" do
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
    item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )

    id = Item.first.id
    previous_name = Item.first.name
    item_params = { name: "NEW NAME"}

    put :update, id: id, item: item_params, format: :json
    item = Item.find_by(id: id)

    expect(response).to be_success
    expect(previous_name).to_not eq item.name
    expect("NEW NAME").to eq item.name
  end

  it "can destroy an item" do
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    item1 = Item.create(name: "Soap", description: "Smells and works like soap", unit_price: 10.25, merchant_id: merchant1.id )
    item2 = Item.create(name: "Towel", description: "Good for drying things", unit_price: 20.50, merchant_id: merchant1.id )

    item = Item.last

    delete :destroy, id: item.id, format: :json

    expect(response).to be_success
    expect(Item.last.name).to eq "Soap"
    expect(Item.first.name).to eq "Soap"
    expect(Item.all.count).to eq 1
  end

end
