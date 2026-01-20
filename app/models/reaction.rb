# Reaction model - represents user reactions (like, heart, etc.) on posts
class Reaction < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :reaction_type, inclusion: { in: %w[like heart haha wow sad angry] }
  validates :user_id, uniqueness: { scope: [:post_id, :reaction_type], message: 'has already reacted with this type' }

  # Get count of reactions by type for a post
  def self.count_by_type(post_id)
    where(post_id: post_id).group(:reaction_type).count
  end

  # Get all reaction types for display
  def self.reaction_types
    %w[like heart haha wow sad angry]
  end
end
