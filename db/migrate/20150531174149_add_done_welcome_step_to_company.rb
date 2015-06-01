class AddDoneWelcomeStepToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :done_welcome_step, :string
  end
end
