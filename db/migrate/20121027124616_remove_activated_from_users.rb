class RemoveActivatedFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :activated
  end

  def down
    add_column :users, :activated, :integer
  end
end
