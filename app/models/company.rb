class Company < ActiveRecord::Base
  has_many :company_users
  has_many :users, through: :company_users

  has_many :invites
end
