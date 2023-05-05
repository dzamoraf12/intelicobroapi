class RestaurantCategory < ApplicationRecord
  self.table_name = "restaurant_categorias"
  belongs_to :restaurant, foreign_key: :restaurant_id
  belongs_to :restaurant_type, foreign_key: :tipo_restaurant_id
end
