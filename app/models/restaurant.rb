class Restaurant < ApplicationRecord
  self.table_name = "restaurants"

  alias_attribute :name, :nombre
  alias_attribute :delivery_service, :servicio_a_domicilio
  alias_attribute :delivery_service_cost, :costo_de_envio
  alias_attribute :minimum_buy, :compra_minima
  alias_attribute :is_open, :abierto
  alias_attribute :head_office, :seleccionado_matriz

  has_many :restaurant_categories
  has_many :restaurant_types, through: :restaurant_categories
  has_one_attached :logo
  has_many :addresses, -> { where( "tipo = 'Restaurant'" ) }, foreign_key: :_id

  def logo_url
    if logo.attached?
      active_storage = IdeallFile.get_active_storage("Restaurant", self.id, "logo")
      url_getter = IdeallFileUrlGetter.new(active_storage)
      url_getter.get_url
    else
      ActionController::Base.helpers.image_url("default_restaurant_logo.png", host: ENV["ROOT_URL"])
    end
  end
end
