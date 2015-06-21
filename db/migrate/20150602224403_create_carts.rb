class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :item_id
      t.integer :user_id
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
