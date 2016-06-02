class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :unit_price, :description

  def unit_price
    object.unit_price.to_i.to_s.insert(-3, ".")
  end
end
