class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  default from: 'hello@workful.co'
end
