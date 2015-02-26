class CreateNewFaces < ActiveRecord::Migration
  def change
    create_table :persistence_new_faces do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
