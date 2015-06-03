class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :amount_credit
      t.integer :unit
      t.integer :price_unit

      t.timestamps null: false
    end
  end
end
