class CustomerSerializer < Blueprinter::Base
  identifier :id
  fields :customer_number, :name, :paternal_name, :maternal_name
end