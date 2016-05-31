require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  it "should get all the merchants" do
    merchant = Merchant.create(name: "Beth")

    get :index, format: :json

    merchants = JSON.parse(response.body)

    expect(Merchant.first.name).to eq "Beth"
  end
end
