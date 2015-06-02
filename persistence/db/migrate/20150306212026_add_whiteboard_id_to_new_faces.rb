class AddWhiteboardIdToNewFaces < ActiveRecord::Migration
  def change
    add_column :persistence_new_faces, :whiteboard_id, :integer
  end
end
