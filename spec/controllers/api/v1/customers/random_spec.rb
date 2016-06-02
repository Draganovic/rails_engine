require 'rails_helper'

RSpec.describe Api::V1::Customers::RandomController, type: :controller do

  describe "GET #show" do
    it "returns a random customer" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")
      customer3= Customer.create(first_name: "Bill", last_name: "Billson")

      get :show, format: :json

      expect(response.status).to eq(200)
      customer = JSON.parse(response.body)
    end
  end

end
