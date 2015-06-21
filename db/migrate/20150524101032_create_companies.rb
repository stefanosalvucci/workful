class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :domain
      t.decimal :monthly_budget, :precision => 8, :scale => 2, default: 0
      t.string :invite_code
      t.boolean :done_welcome, default: false

      t.timestamps null: false
    end
  end
end
