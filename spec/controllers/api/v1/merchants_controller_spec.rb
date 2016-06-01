require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  it "should get all the merchants" do
    merchant = Merchant.create(name: "Beth")

    get :index, format: :json

    merchants = JSON.parse(response.body)

    expect(merchants.first["name"]).to eq "Beth"
  end

  it "can view one merchant" do
    merchant1 = Merchant.create(name: "Beth")
    merchant2 = Merchant.create(name: "Frank")
    merchant3 = Merchant.create(name: "Tom")

    id = Merchant.last.id

    get "show", id: id, format: :json

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq id
  end
end
