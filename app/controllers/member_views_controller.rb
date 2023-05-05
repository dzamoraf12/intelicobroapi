class MemberViewsController < ActionController::Base
  def reset_password
    @url_base = ENV.fetch("ROOT_URL_NGROK") { ENV["ROOT_URL"] }
    render "member_views/reset_password", layout: false
  end
end
