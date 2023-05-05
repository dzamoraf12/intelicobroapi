class RestaurantTypeSerializer < Blueprinter::Base
    identifier :id
    fields :name, :icon_url, :picture_url
end