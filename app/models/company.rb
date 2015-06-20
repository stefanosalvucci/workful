# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string
#  url               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  done_welcome      :boolean
#  done_welcome_step :string
#  phone_number      :string
#  email_company     :string
#  stripe_id         :string
#

class Company < ActiveRecord::Base
  has_many :company_users
  has_many :users, through: :company_users

  has_many :invites
end
