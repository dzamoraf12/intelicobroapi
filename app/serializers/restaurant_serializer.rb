class RestaurantSerializer < Blueprinter::Base
  identifier :id
  fields :name, :delivery_service, :delivery_service_cost, :minimum_buy, :is_open,
         :head_office, :logo_url
  
  association :addresses, blueprint: AddressSerializer
end