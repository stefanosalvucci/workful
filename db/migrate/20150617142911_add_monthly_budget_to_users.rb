class AddMonthlyBudgetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :monthly_budget, :decimal, :precision => 8, :scale => 2, default: 0
  end
end
