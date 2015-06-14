require 'valid_email'

class Invite < ActiveRecord::Base
  belongs_to :company

  before_save :generate_code

  after_create :send_invite

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true, email: true

  def generate_code
    loop do
      self.invite_code = SecureRandom.hex(10)
      break unless self.class.exists?(invite_code: invite_code)
    end
    self.invite_code = invite_code
  end

  def send_invite
    #InviteMailer.delay.send_invite(self)
    InviteMailer.send_invite(self).deliver
  end
end
