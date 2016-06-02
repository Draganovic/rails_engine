class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :unit_price, :description

  def unit_price
    sprintf('%.02f', (object.unit_price / 100.0)) rescue binding.pry
  end
end
