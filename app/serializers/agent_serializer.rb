class AgentSerializer < Blueprinter::Base
  identifier :id
  fields :code, :name, :phone, :cellphone
end