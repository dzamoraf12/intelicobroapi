class AddAgentReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :agent_id, :integer
    add_index :users, [:agent_id], unique: true
  end
end
