class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def random
     num = rand(Customer.count)
     Customer.offset(num).first
   end
end
