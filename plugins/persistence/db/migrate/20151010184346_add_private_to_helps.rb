class AddPrivateToHelps < ActiveRecord::Migration
  def change
    add_column :persistence_helps, :private, :boolean
  end
end
