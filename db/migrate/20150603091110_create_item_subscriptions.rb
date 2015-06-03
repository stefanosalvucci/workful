class CreateItemSubscriptions < ActiveRecord::Migration
  def change
    create_table :item_subscriptions do |t|
      t.integer :item_id
      t.integer :user_id
      t.float :amount_credit
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
