class AddPrivacyToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :private, :boolean,default: true
  end
end
