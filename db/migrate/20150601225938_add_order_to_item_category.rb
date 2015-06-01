class AddOrderToItemCategory < ActiveRecord::Migration
  def change
    add_column :item_categories, :order, :integer
  end
end
