class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  default from: "\"Workful\" <workfuldevelopment@gmail.com>"

  def request_demo_confirmation email
    subject = "Request confirmation"
    mail(subject: subject, to: email)
  end

end
