class CreateProspects < ActiveRecord::Migration[7.0]
  def change
    create_table :prospects do |t|
      t.string :names
      t.string :mother_surname
      t.string :father_surname
      t.string :street
      t.string :internal_number
      t.string :external_number
      t.integer :zip_code
      t.string :neighborhood
      t.string :municipality
      t.string :city
      t.string :state
      t.string :latitude
      t.string :longitude
      t.integer :verification_status, default: 0
      t.datetime :verified_at
      t.datetime :verification_accepted_at
      t.datetime :verification_rejected_at
      t.integer :agent_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
