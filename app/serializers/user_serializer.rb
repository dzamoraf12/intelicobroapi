class UserSerializer < Blueprinter::Base
  identifier :id
  fields :email, :name, :lastname, :cellphone

  association :agent, blueprint: AgentSerializer
end