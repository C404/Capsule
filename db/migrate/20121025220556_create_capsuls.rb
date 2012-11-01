class CreateCapsuls < ActiveRecord::Migration
  def change
    create_table :capsuls do |t|
      t.string :content
      t.string :video
      t.integer :user_id

      t.timestamps
    end
  end
end
