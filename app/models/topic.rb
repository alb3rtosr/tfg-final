class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
end
