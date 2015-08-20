class AddArchivedFlagToEntityTables < ActiveRecord::Migration
  def change
    add_column :persistence_new_faces,    :archived, :boolean, default: false, null: false
    add_column :persistence_interestings, :archived, :boolean, default: false, null: false
    add_column :persistence_events,       :archived, :boolean, default: false, null: false
    add_column :persistence_helps,        :archived, :boolean, default: false, null: false
  end
end
