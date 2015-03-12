class AddTeamIdToNewFaces < ActiveRecord::Migration
  def change
    add_column :persistence_new_faces, :team_id, :integer
  end
end
