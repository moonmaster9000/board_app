class AddTitleToHelps < ActiveRecord::Migration
  def change
    add_column :persistence_helps, :title, :string
  end
end
