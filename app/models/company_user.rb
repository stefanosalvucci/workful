class CompanyUser < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  enum role_in_company: { user: 0, owner: 1 }
end
