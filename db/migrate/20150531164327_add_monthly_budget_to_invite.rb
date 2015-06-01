class AddMonthlyBudgetToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :monthly_budget, :decimal
  end
end
