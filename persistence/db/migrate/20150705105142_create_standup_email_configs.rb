class CreateStandupEmailConfigs < ActiveRecord::Migration
  def change
    create_table :persistence_standup_email_configs do |t|
      t.string :to_address
      t.string :from_address
      t.string :subject_prefix
      t.integer :whiteboard_id

      t.timestamps
    end
  end
end
