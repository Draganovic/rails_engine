require 'rails_helper'

RSpec.describe Api::V1::Customers::FindersController, type: :controller do

  describe "GET #show" do
    it "returns the one customer with the given attribute" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Tom", last_name: "Tompson")

      get :show, id: customer1.id, format: :json

      expect(response.status).to eq(200)
      customer =  JSON.parse(response.body)

      expect(customer['first_name']).to eq "Bob"

      get :show, first_name: customer2.first_name, format: :json
      customer2 =  JSON.parse(response.body)

      expect(customer2['first_name']).to eq "Tom"
    end
  end

  describe "GET #index" do
    it "returns all the customers with the given attribute" do
      customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
      customer2= Customer.create(first_name: "Bob", last_name: "Tompson")

      customers = [customer1, customer2]

      get :index, id: customer1.id, format: :json
      expect(response.status).to eq(200)
      customer =  JSON.parse(response.body)

      expect(customer[0]['first_name']).to eq "Bob"
      get :index, first_name: "Bob", format: :json
      customers = JSON.parse(response.body)

      expect(customers.count).to eq(2)

      first_customer = customers.first
      last_customer = customers.last

      expect(response.status).to eq(200)
      expect(customer1.id).to eq(first_customer['id'])
      expect(customer2.id).to eq(last_customer['id'])
    end
  end

end
