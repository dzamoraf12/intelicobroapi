class AddCellphoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cellphone, :string, after: :lastname, limit: 15
  end
end
