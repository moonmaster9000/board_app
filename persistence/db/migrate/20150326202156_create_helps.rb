class CreateHelps < ActiveRecord::Migration
  def change
    create_table :persistence_helps do |t|
      t.string :team_id
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
