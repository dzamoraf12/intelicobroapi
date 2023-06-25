class AddDeletedAtToProspect < ActiveRecord::Migration[7.0]
  def change
    add_column :prospects, :deleted_at, :datetime, after: :verification_rejected_at
    add_index :prospects, :deleted_at
  end
end
