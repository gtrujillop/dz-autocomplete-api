class Category < ActiveRecord::Base
  has_many :suggestions
  validates :name, presence: true, uniqueness: true
end
