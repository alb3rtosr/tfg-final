class Subscription < ApplicationRecord
  validates :user_id, uniqueness: { scope: :topic_id }

  belongs_to :user
  belongs_to :topic
end
