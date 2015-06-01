class AddCompanyIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :company_id, :integer
  end
end
