class AddPrivateToInterestings < ActiveRecord::Migration
  def change
    add_column :persistence_interestings, :private, :boolean
  end
end
