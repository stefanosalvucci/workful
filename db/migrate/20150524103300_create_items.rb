class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price_unit
      t.integer :min_price_unit
      t.integer :item_category_id

      t.timestamps null: false
    end
  end
end
