class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  default from: "\"Workful\" <elena@workful.co>"

  def request_demo_confirmation email
    subject = "Request confirmation"
    mail(subject: subject, to: email)
  end

  def notify_demo_request email, request
    @request = request
    subject = "Someone is interested in workful!"
    mail(subject: subject, to: email)
  end

end
