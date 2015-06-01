class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :company_user
  has_one :company, through: :company_user

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
