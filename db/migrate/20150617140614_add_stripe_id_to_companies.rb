class AddStripeIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :stripe_id, :string
  end
end
