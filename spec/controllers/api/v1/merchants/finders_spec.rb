require 'rails_helper'

RSpec.describe Api::V1::Merchants::FindersController, type: :controller do

  describe "GET #show" do
    it "returns the one merchant with the given attribute" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      merchant3 = Merchant.create(name: "Tom")

      get :show, id: merchant1.id, format: :json

      expect(response.status).to eq(200)
      parsed_merchant1 = JSON.parse(response.body)

      expect(merchant1.name).to eq(parsed_merchant1['name'])

      get :show, name: merchant3.name.upcase, format: :json
      parsed_merchant3 = JSON.parse(response.body)

      expect(merchant3.name).to eq(parsed_merchant3['name'])
    end
  end

  describe "GET #index" do
    it "returns all the merchants with the given attribute" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Beth")
      merchant3 = Merchant.create(name: "Tom")

      merchants = [merchant1, merchant2, merchant3]

      get :index, name: "Tom", format: :json
      expect(response.status).to eq(200)

      parsed_merchant = JSON.parse(response.body)

      expect(merchant3.id).to eq(parsed_merchant.first['id'])

      get :index, name: "Beth", format: :json
      parsed_merchants = JSON.parse(response.body)

      expect(parsed_merchants.count).to eq(2)

      first_merchant = parsed_merchants.first
      last_merchant = parsed_merchants.last

      expect(response.status).to eq(200)
      expect(merchant1.id).to eq(first_merchant['id'])
      expect(merchant2.id).to eq(last_merchant['id'])
    end
  end
end
