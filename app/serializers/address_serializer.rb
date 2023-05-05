class AddressSerializer < Blueprinter::Base
  identifier :id
  fields :alias, :street, :external_number, :between_streets, :street1, :street2, :details, :type
end