# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string
#  domain            :string
#  monthly_budget    :decimal(8, 2)    default(0.0)
#  invite_code       :string
#  done_welcome      :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  done_welcome_step :string
#  stripe_id         :string
#

class Company < ActiveRecord::Base
  has_many :company_users
  has_many :users, through: :company_users

  validates :monthly_budget, presence: true, numericality: true, format: { :with => /\A\d{1,4}(\.\d{0,2})?\z/ }

  before_save :generate_unique_invite_url, on: :commit

  def generate_unique_invite_url
    loop do
      self.invite_code = SecureRandom.hex(10)
      break unless self.class.exists?(invite_code: invite_code)
    end
    self.invite_code = invite_code
  end
end
