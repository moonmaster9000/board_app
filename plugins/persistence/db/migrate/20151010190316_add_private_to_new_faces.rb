class AddPrivateToNewFaces < ActiveRecord::Migration
  def change
    add_column :persistence_new_faces, :private, :boolean
  end
end
