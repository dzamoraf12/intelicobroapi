class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :jwt_authenticatable, :validatable,
         jwt_revocation_strategy: JwtDenylist

  has_one_attached :avatar

  validates :name, :lastname, presence: true, on: %i[update], unless: :reset_password_in_process?

  def avatar_url
    if avatar.attached?
      active_storage = IdeallFile.get_active_storage("User", self.id, "avatar")
      url_getter = IdeallFileUrlGetter.new(active_storage)
      url_getter.get_url
    else
      ActionController::Base.helpers.image_url("default_avatar.png", host: ENV["ROOT_URL"])
    end
  end

  def reset_password_in_process?
    self.reset_password_token.present?
  end
end
