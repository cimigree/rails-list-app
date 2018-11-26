class Item < ApplicationRecord
  has_many :item_stores
  has_many :stores, through: :item_stores, dependent: :destroy
  belongs_to :category, optional: :true

  scope :needed, -> { where(purchased: false) }
  scope :uniq_categories, -> { select(:category_id).distinct.pluck(:category_id) }

  accepts_nested_attributes_for :item_stores
  accepts_nested_attributes_for :stores

  validates :frequency, inclusion: { in: ["weekly", "biweekly", "monthly", "as needed"], message: "%{value} is not a valid frequency" }
  validates :purchased, inclusion: { in: [true, false] }, allow_blank: true
  validates :name, presence: { message: "Enter name" }
end