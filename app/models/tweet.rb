class Tweet < ActiveRecord::Base
  default_scope { order(:created_at => :desc) }
  belongs_to :user
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :status
  has_many :favorite_tweets
  has_many :favorited_by, through: :favorite_tweets
  acts_as_commentable
end
