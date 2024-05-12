class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :path
      t.string :name
      t.integer :plays

      t.timestamps
    end
  end
end
