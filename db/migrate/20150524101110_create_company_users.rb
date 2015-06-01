class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :role_in_company

      t.timestamps null: false
    end
  end
end
