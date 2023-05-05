class UserMailer < Devise::Mailer
  default from: "<#{ENV['DEFAULT_FROM_EMAIL']}>"
  before_action :add_inline_attachments!

  def reset_password_instructions(record, token, opts={})
    @url = ENV.fetch("ROOT_URL_NGROK") { ENV["ROOT_URL"] }
    super
  end

  private
  def add_inline_attachments!
    attachments.inline["logo-web.png"] = File.read(Rails.root.join("public/logo-web.png"))
  end
end
