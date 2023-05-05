class AddPersonalDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, after: :email, limit: 100
    add_column :users, :lastname, :string, after: :name, limit: 100
  end
end
