class AddCapsuleToUser < ActiveRecord::Migration
  def change
    add_column :users, :capsule, :integer
  end
end
