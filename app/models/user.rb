class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :followed_user_relationships, foreign_key: "follower_id", class_name: "FollowingRelationship"
  has_many :followed_users, through: :followed_user_relationships

  has_many :following_user_relationships, foreign_key: "followed_user_id", class_name: "FollowingRelationship"
  has_many :following_users, through: :following_user_relationships, source: :follower
  has_many :favorite_tweets
  has_many :favorites, through: :favorite_tweets,source: :tweet
  belongs_to :college
  def timeline
    Tweet.where(user_id: self_and_followed_user_ids)
  end

  def self_and_followed_user_ids
    followed_user_ids + [id]
  end

  def follow(followed_user)
    followed_users << followed_user
  end

  def can_follow?(user)
    !self_and_followed_user_ids.include?(user.id)
  end
end
