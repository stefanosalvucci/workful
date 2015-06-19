class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :company_user
  has_one :company, through: :company_user

  has_many :order_items

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :item_subscriptions

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def has_order?
    return true if self.order_items.present?
  end

  def has_cc?
    return true if self.stripe_id.present?
  end

  def monthly_budget_left
    self.monthly_budget - self.item_subscriptions.sum(:amount_credit)
  end
end
