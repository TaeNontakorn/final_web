class Post < ApplicationRecord
  # Validations
  validates :titel, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :keyword, presence: true, length: { maximum: 100 }
  validates :user, presence: true

  # Active Storage association
  has_many_attached :images
  validate :validate_images

  # Association
  belongs_to :user

  has_many :comments

  # Callbacks
  before_create :randomize_id

  private

  # Generate a random ID
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while Post.exists?(id: self.id)
  end

  # Validate image upload limit
  def validate_images
    if images.attached? && images.length > 5
      errors.add(:images, "cannot have more than 5 images")
    end
  end
end
