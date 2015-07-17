class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :fullname
      t.string :email
      t.string :company_name

      t.timestamps null: false
    end
  end
end
