class College < ActiveRecord::Base
  has_many :users
  has_many :tweets 
  def timeline
    Tweet.where(user_id: user_ids)
  end

  def user_ids
    user_ids
  end
end
