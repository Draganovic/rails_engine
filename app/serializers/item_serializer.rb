class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :unit_price, :description
end
