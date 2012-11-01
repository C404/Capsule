class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :content
      t.references :capsul

      t.timestamps
    end
    add_index :comments, :capsul_id
  end
end
