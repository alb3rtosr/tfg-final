class Model3d < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_one_attached :file, dependent: :destroy
  validate :image_presence
  validates :description, presence: true, length: { maximum: 100 }
  validates :file, presence: true
  validates :user_id, presence: true
  validate :image_format
  validate :file_extension
  
  
  
  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end
  def model_presence
    errors.add(:file, "can't be blank") unless file.attached?
  end

  def image_format
    return unless image.attached?

    unless image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, 'must be a valid image format (JPEG, PNG, GIF)')
    end
  end

  def file_extension
    return unless file.attached?

    allowed_extensions = %w[.stl .obj]
    unless allowed_extensions.include?(File.extname(file.filename.to_s))
      errors.add(:file, 'must have a .stl or .obj extension')
    end
  end
end
