# Post model representing a blog post
class Post < ApplicationRecord
  # Validations - ensure title and content are present
  validates :title, presence: true
  validates :content, presence: true
end
