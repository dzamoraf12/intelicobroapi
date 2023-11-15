class AddDeletedAtToVisits < ActiveRecord::Migration[7.0]
  def change
    add_column :visits, :deleted_at, :datetime, after: :user_id
    add_index :visits, :deleted_at
  end
end
