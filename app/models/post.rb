# Post model representing a social media post
class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  # Validations
  # Title is optional (posts can be image-only)
  validates :content, presence: true, unless: -> { image_url.present? }
  validates :title, presence: true, unless: -> { image_url.present? || content.present? }
  # At least one of content, title, or image_url must be present
  validate :must_have_content_or_image

  # Scopes
  scope :recent, -> { order(created_at: :desc) }

  # Instance methods
  # Get reaction counts grouped by type
  def reaction_counts
    reactions.group(:reaction_type).count
  end

  # Check if a user has reacted with a specific type
  def user_reacted?(user, reaction_type)
    return false unless user
    reactions.exists?(user_id: user.id, reaction_type: reaction_type)
  end

  private

  # Custom validation - ensure post has some content
  def must_have_content_or_image
    if content.blank? && title.blank? && image_url.blank?
      errors.add(:base, 'Post must have content, title, or an image')
    end
  end
end

