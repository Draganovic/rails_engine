require 'rails_helper'

RSpec.describe Api::V1::Merchants::RandomController, type: :controller do

  describe "GET #show" do
    it "returns a random merchant" do
      merchant1 = Merchant.create(name: "Beth")
      merchant2 = Merchant.create(name: "Frank")
      merchant3 = Merchant.create(name: "Tom")

      get :show, format: :json

      expect(response.status).to eq(200)
      merchant = JSON.parse(response.body)
    end
  end

end
