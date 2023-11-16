class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.decimal :penalty_amount, precision: 12, scale: 2
      t.text :comments
      t.string :latitude
      t.string :longitude
      t.integer :customer_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
