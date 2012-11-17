class CreateCapsulsTagsJoinTable < ActiveRecord::Migration
  def up
    create_table :capsuls_tags, :id => false do |t|
        t.references :capsul
        t.references :tag
    end
    add_index :capsuls_tags, [:capsul_id, :tag_id], :unique => true
    add_index :capsuls_tags, [:tag_id, :capsul_id], :unique => true
  end

  def down
    drop_table :capsuls_tags
  end
end
