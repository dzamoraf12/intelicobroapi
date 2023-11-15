class VisitSerializer < Blueprinter::Base
  identifier :id
  fields :penalty_amount, :comments, :latitude, :longitude, :created_at

  association :customer, blueprint: CustomerSerializer
  association :user, blueprint: UserSerializer
end