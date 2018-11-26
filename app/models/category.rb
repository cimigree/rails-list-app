class Category < ApplicationRecord
  scope :needed_items, -> { category.items.needed }
  has_many :items

  validates_presence_of :name
end