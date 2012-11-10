class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.string :fb_token
      t.string :fb_username
      t.string :fb_email
      t.string :da_token
      t.string :da_email
      t.string :tw_token
      t.string :tw_username
      t.references :user

      t.timestamps
    end
    add_index :user_tokens, :user_id
  end
end
