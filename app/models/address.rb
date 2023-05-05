class Address < ApplicationRecord
  self.table_name = "direcciones"

  alias_attribute :street, :calle
  alias_attribute :external_number, :numero
  alias_attribute :between_streets, :entre_calles
  alias_attribute :street1, :calle1
  alias_attribute :street2, :calle2
  alias_attribute :details, :detalles
  alias_attribute :type, :tipo
  # `direcciones`.`status`,
  # `direcciones`.`_id`,
  # `direcciones`.`colonia_id`,
  # `direcciones`.`ciudad_id`,

end
