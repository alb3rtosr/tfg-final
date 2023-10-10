class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :nickname,  length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :reviews
  has_many :subscriptions
  has_many :topics, through: :subscriptions
  has_many :topics
  has_many :project_users
  has_many :projects, through: :project_users  
  has_many :model3ds, dependent: :destroy
  has_one_attached :avatar  do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  validates :avatar, content_type: { in: %w[image/jpeg image/gif
    image/png image/jpg],
     message: "must be a valid
    image format" },
     size: { less_than: 10.megabytes,
     message: "should be less than 10MB"
    }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  attribute :experience, :integer, default: 0
  attribute :level, :integer, default: 1

  def update_experience_and_level(points)
    self.experience += points
    update_level
    save
  end

  private

  def update_level
    self.level = experience / 1000 + 1
  end
  has_many :flags, as: :flaggable, dependent: :destroy
  has_many :received_flags, class_name: "Flag", foreign_key: "user_id", dependent: :destroy
end
