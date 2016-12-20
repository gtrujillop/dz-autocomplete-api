class SuggestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image
  has_one :category
end
