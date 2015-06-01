class AddEmailCompanyToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email_company, :string
  end
end
