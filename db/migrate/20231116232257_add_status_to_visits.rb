class AddStatusToVisits < ActiveRecord::Migration[7.0]
  def change
    add_column :visits, :status, :integer, after: :longitude, default: 0
  end
end
