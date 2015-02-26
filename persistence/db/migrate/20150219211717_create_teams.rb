class CreateTeams < ActiveRecord::Migration
  def change
    create_table :persistence_teams do |t|
      t.string :name
      t.timestamps
    end
  end
end
