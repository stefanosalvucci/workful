# == Schema Information
#
# Table name: company_users
#
#  id              :integer          not null, primary key
#  company_id      :integer
#  user_id         :integer
#  role_in_company :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CompanyUser < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  enum role_in_company: { user: 0, owner: 1 }
end
