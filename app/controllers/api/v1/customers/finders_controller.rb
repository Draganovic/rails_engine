class Api::V1::Customers::FindersController < ApplicationController
  respond_to :json

  def show
    respond_with find_customers.first
  end

  def index
    respond_with find_customers
  end

private
def build_query
    query = []
    query << "first_name ILIKE '#{customer_name_params[:first_name]}'" if customer_name_params[:first_name]
    query << "last_name ILIKE '#{customer_name_params[:last_name]}'" if customer_name_params[:last_name]
    query.join(" AND ")
  end

  def customer_params
   params.permit(:created_at, :id, :updated_at)
  end

  def customer_name_params
    params.permit(:first_name, :last_name)
  end

  def find_customers
    customers = Customer.where(customer_params)
  unless customer_name_params.empty?
    customers = customers.where(build_query)
  end
  customers
end

end
