class RemoveProspectsFieldsFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :clientes, :verification_agent_id
    remove_column :clientes, :verification_status
    remove_column :clientes, :verification_comments
    remove_column :clientes, :verified_at
    remove_column :clientes, :verification_accepted_at
  end
end
