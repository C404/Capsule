class AddActivatedColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :integer
  end
end
