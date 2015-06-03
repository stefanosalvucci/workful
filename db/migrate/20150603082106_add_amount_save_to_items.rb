class AddAmountSaveToItems < ActiveRecord::Migration
  def change
    add_column :items, :amount_save, :integer
  end
end
