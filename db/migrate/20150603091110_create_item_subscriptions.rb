class CreateItemSubscriptions < ActiveRecord::Migration
  def change
    create_table :item_subscriptions do |t|
      t.integer :item_id
      t.integer :user_id
      t.decimal :amount_credit, :precision => 8, :scale => 2
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
