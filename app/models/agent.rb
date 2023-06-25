class Agent < ApplicationRecord
  self.table_name = "agentes"

  alias_attribute :code, :Codigo
  alias_attribute :name, :Nombre
  alias_attribute :address, :Domicilio
  alias_attribute :phone, :Telefono
  alias_attribute :cellphone, :Celular
  alias_attribute :active, :Activo
  alias_attribute :type, :Tipo

  has_one :user
  has_many :prospects
end
