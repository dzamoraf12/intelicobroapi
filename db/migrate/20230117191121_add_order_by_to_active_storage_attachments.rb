class AddOrderByToActiveStorageAttachments < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :position, :integer, default: 0
  end
end
