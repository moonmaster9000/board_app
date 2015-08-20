class CreateEvents < ActiveRecord::Migration
  def change
    create_table :persistence_events do |t|
      t.string  :title
      t.string  :description
      t.date    :date
      t.integer :whiteboard_id

      t.timestamps
    end
  end
end
