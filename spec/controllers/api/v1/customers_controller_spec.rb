require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  it "should get all the customers" do
    customer1 = Customer.create(first_name: "Bob", last_name: "Dillan")
    customer2= Customer.create(first_name: "Tom", last_name: "Tompson")

    get :index, format: :json

    merchants = JSON.parse(response.body)

    expect(Customer.first.first_name).to eq "Bob"
  end
end
