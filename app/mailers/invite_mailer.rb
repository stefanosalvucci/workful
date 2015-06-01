class InviteMailer < ApplicationMailer
  def send_invite(invite)
    return unless invite.present?

    @invite = invite

    mail(to: @invite.email, subject: "Join #{@invite.company.name} on Workful")
  end
end
