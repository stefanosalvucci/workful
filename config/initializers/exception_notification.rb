if Rails.env.production? || Rails.env.staging?
  Rails.application.config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[WORKFUL #{ Rails.env }] ",
      :sender_address => %{cacchio! <holyshit@workful.com>},
      :exception_recipients => %w{stefanosalvucci@gmail.com}
    }
end
