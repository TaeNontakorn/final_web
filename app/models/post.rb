class Post < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 250 }
  #validates :keyword, presence: true, length: { maximum: 100 }
  validates :user, presence: true

  # Active Storage association
  has_many_attached :images
  validate :validate_images

  # Associations
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy

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


  scope :search_by_title, ->(query) { where('title LIKE ?', "%#{query}%") }
  scope :search_by_description, ->(query) { where('description LIKE ?', "%#{query}%") }
  scope :search_by_keyword, ->(query) { where('keyword LIKE ?', "%#{query}%") }

  def self.search(query)
    return all unless query.present?

    search_by_title(query)
      .or(search_by_description(query))
      .or(search_by_keyword(query))
  end

 
end
