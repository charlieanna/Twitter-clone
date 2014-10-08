class Timeline
  include ActiveModel::Model
  def initialize(user)
    @user = user
  end

  def tweets
    Tweet.where(user_id: user_ids) #+ @user.college.tweets + @user.groups.tweets
  end
  def user_ids
    [@user.id] + @user.followed_user_ids
  end
end
