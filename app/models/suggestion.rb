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
      only: [:name, :price],
      include: [:category]
    )
  end

  # def self.search(query)
  #   __elasticsearch__.search(
  #     {
  #       query: {
  #         multi_match: {
  #           query: query,
  #           fields: ['name^10', 'price', 'category_id']
  #         }
  #       }
  #     }
  #   )
  # end

end
