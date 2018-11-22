class Store < ApplicationRecord
  has_many :item_stores
  has_many :items, through: :item_stores, dependent: :destroy

  accepts_nested_attributes_for :item_stores, allow_destroy: true

  validates_presence_of :name
end