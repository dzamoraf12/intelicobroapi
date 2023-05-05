class RestaurantType < ApplicationRecord
  self.table_name = "tipos_restaurant"
  
  alias_attribute :name, :tipo

  has_many :restaurant_category, foreign_key: :tipo_restaurant_id
  has_many :restaurant, through: :restaurant_category
  has_one_attached :icon
  has_one_attached :picture

  scope :actives, -> { select("tipos_restaurant.id, tipo").joins(:restaurant) }

  def icon_url
    asset_url("icon")
  end

  def picture_url
    asset_url("picture")
  end

  def asset_url(type)
    if eval(type).attached?
      active_storage = IdeallFile.get_active_storage("RestaurantType", self.id, type)
      url_getter = IdeallFileUrlGetter.new(active_storage)
      url_getter.get_url
    else
      ActionController::Base.helpers.image_url("default_restaurant_category_#{type}.png", host: ENV["ROOT_URL"])
    end
  end
end
