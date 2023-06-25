class AddAgentReferenceToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :verification_agent_id, :integer
  end
end
