class CreateItemSubscriptions < ActiveRecord::Migration
  def change
    create_table :item_subscriptions do |t|
      t.integer :item_id
      t.integer :user_id
      t.string :service_email
      t.decimal :amount, :precision => 8, :scale => 2, default: 0.0

      t.timestamps null: false
    end
  end
end
