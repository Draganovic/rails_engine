class Customer < ActiveRecord::Base

  def random
     num = rand(Customer.count)
     Customer.offset(num).first
   end
end
