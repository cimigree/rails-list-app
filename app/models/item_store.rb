class ItemStore < ApplicationRecord
  belongs_to :item
  belongs_to :store

  validates :store_id, presence: { message: 'Select store' }
  validates :item_id, presence: { message: 'Select item'}
end