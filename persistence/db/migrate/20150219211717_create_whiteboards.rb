class CreateWhiteboards < ActiveRecord::Migration
  def change
    create_table :persistence_whiteboards do |t|
      t.string :name
      t.timestamps
    end
  end
end
