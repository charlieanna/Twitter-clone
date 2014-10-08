class Dashboard
  def initialize(user)
    @user = user
  end

  def new_tweet
    Tweet.new
  end

  def timeline
    Timeline.new(@user)
  end
end
