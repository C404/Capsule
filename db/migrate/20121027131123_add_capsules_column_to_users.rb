class AddCapsulesColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :capsules, :integer
  end
end
