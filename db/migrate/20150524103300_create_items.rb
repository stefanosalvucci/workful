class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :min_credit, :decimal, :precision => 8, :scale => 2, default: 0
      t.integer :max_credit, :decimal, :precision => 8, :scale => 2, default: 0
      t.integer :item_category_id
      t.string :description
      t.string :custom_signup_url
      t.timestamps null: false
    end
  end
end
