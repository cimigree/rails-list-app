class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :brand_name
      t.string :quantity
      t.boolean :coupon, default: false
      t.text :note
      t.boolean :purchased, null: false, default: false
      t.string :frequency, null: false
      t.date :date_purchased
      t.date :next_purchase_date
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
