class CreateCapsuls < ActiveRecord::Migration
  def change
    create_table :capsuls do |t|
      t.string :description
      t.string :video
      t.references :user

      t.timestamps
    end
    add_index :capsuls, :user_id
  end
end
