# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  stripe_id              :string
#  monthly_budget         :decimal(8, 2)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :company_user
  has_one :company, through: :company_user

  has_many :carts, foreign_key: 'user_id'

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :item_subscriptions

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def has_order?
    return true if self.carts.present?
  end

  def has_cc?
    return true if self.stripe_id.present?
  end

  def monthly_budget_left
    self.monthly_budget - self.item_subscriptions.sum(:amount)
  end
end
