class ChangeNullToTrueAgentOnProspects < ActiveRecord::Migration[7.0]
  def change
    change_column_null :prospects, :agent_id, true
  end
end
