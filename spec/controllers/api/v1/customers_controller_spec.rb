require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  it "should get all the customers" do
    customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
    customer2= Customer.create(first_name: "Tom", last_name: "Tompson")

    get :index, format: :json

    customers = JSON.parse(response.body)

    expect(customers.first["first_name"]).to eq "Bob"
  end

  it "can view one customer" do
    customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
    customer2= Customer.create(first_name: "Tom", last_name: "Tompson")

    id = Customer.last.id

    get "show", id: id, format: :json

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq id
  end
end
