class Item < ActiveRecord::Base
  belongs_to :merchant

  def random
    num = rand(Item.count)
    Item.offset(num).first
  end
  
end
