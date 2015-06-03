class AddMinCreditToItem < ActiveRecord::Migration
  def change
    add_column :items, :min_credit, :float
  end
end
