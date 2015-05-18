class CreateInterestings < ActiveRecord::Migration
  def change
    create_table :persistence_interestings do |t|
      t.string :description
      t.string :title
      t.date :date
      t.integer :team_id

      t.timestamps
    end
  end
end
