class AddActiveColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean
  end
end
