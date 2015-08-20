class CreatePosts < ActiveRecord::Migration
  def change
    create_table :persistence_posts do |t|
      t.integer :whiteboard_id
      t.string :title
      t.date :standup_date
      t.timestamps
    end
  end
end
