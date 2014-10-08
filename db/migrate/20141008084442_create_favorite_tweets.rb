class CreateFavoriteTweets < ActiveRecord::Migration
  def change
    create_table :favorite_tweets do |t|
      t.string :tweet_id
      t.string :integer
      t.integer :user_id

      t.timestamps
    end
  end
end
