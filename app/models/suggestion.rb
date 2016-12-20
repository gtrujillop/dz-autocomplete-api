class Suggestion < ActiveRecord::Base
  include Filterable

  belongs_to :category
  validates :name, presence: true, uniqueness: true

  scope :q, -> (querystring) { where("LOWER(name) LIKE ?", "%#{querystring}%") }
  scope :min_price, -> (minprice) { where("price >= ?", "#{minprice}") }
  scope :max_price, -> (maxprice) { where("price <= ?", "#{maxprice}") }
  scope :cat, -> (category_id) { where("category_id = ?", "#{category_id}") }

end
