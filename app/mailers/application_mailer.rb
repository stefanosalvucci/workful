class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  default from: "\"Workful\" <elena@workful.co>"

  def request_demo_confirmation email
    subject = "Request confirmation"
    mail(subject: subject, to: email)
  end

end
