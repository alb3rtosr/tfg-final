class Review < ApplicationRecord
  belongs_to :user
  validates_inclusion_of :likert, in: 1..5, message: 'must be between 1 and 5'
end
