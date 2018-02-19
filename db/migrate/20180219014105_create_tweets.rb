class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :user_handle, limit: 24
      t.integer :followers
      t.string :message, limit: 280
      t.float :sentiment
      t.datetime :published

      t.timestamps

      t.index [:published]
      t.index [:sentiment]
    end
  end
end
