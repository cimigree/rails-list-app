class CreateItemStores < ActiveRecord::Migration[5.2]
  def change
    create_table :item_stores do |t|
      t.references :item, null: false
      t.references :store, null: false 

      t.timestamps
    end
  end
end
