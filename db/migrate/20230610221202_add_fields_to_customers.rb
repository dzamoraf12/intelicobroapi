class AddFieldsToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :verification_status, :integer, default: 0
    add_column :clientes, :verification_comments, :text
    add_column :clientes, :verified_at, :datetime
    add_column :clientes, :verification_accepted_at, :datetime
  end
end
