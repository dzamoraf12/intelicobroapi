options = { forward_emails_to: "daniel.zamoraf@gmail.com",
            deliver_emails_to: [] }

unless (Rails.env.test? || Rails.env.production?)
  interceptor = MailInterceptor::Interceptor.new(options)
  ActionMailer::Base.register_interceptor(interceptor)
end