class AddDoneWelcomeToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :done_welcome, :boolean
  end
end
