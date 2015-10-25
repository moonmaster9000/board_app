class AddAuthorToStandupItems < ActiveRecord::Migration
  def change
    add_column :persistence_new_faces,    :author, :string
    add_column :persistence_events,       :author, :string
    add_column :persistence_interestings, :author, :string
    add_column :persistence_helps,        :author, :string
  end
end
