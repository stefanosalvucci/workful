class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :invite_code
      t.boolean :joined, default: false

      t.timestamps null: false
    end
  end
end
