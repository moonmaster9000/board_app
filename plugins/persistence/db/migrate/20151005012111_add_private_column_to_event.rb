class AddPrivateColumnToEvent < ActiveRecord::Migration
  def change
    add_column :persistence_events, :private, :boolean
  end
end
