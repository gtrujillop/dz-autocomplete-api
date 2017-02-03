require 'elasticsearch/model'

class Suggestion < ActiveRecord::Base
  # include Filterable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :category
  validates :name, presence: true, uniqueness: true

  # scope :q, -> (querystring) { where("LOWER(name) LIKE ?", "%#{querystring}%") }
  # scope :min_price, -> (minprice) { where("price >= ?", "#{minprice}") }
  # scope :max_price, -> (maxprice) { where("price <= ?", "#{maxprice}") }
  # scope :cat, -> (category_id) { where("category_id = ?", "#{category_id}") }

  def as_indexed_json(options={})
    as_json(
      only: [:name, :price, :category_id],
      include: [:category],
      methods: [:category_name]
    )
  end

  def self.search(criteria)
    __elasticsearch__.search(
      {
        query: {
          bool: {
            must: [
              {
                wildcard: {
                  name: "*#{criteria[:q]}*"
                }
              },
              {
                wildcard: {
                  category_name: "*#{criteria[:cat]}*"
                }
              }
            ],
            filter: {
              range: {
                price: {
                  lt: criteria[:max_price],
                  gt: criteria[:min_price]
                }
              }
            }
          }
        }
      }
    )
  end

  def category_name
    category.name
  end

end
