# Helper methods for reactions display
module ReactionsHelper
  # Get Lucide icon name for reaction type
  # Returns simple icon names that match the reaction type
  def reaction_icon(reaction_type)
    icons = {
      'like' => 'thumbs-up',
      'heart' => 'heart',
      'haha' => 'smile',
      'wow' => 'zap',
      'sad' => 'frown',
      'angry' => 'flame'
    }
    icons[reaction_type] || 'thumbs-up'
  end
end
