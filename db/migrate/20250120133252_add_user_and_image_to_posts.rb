class AddUserAndImageToPosts < ActiveRecord::Migration[7.1]
  def up
    # Add columns
    add_reference :posts, :user, null: true, foreign_key: false
    add_column :posts, :image_url, :string

    # If there are existing posts, delete them (they have no user)
    # This is a migration from blog to social media - old posts are orphaned
    Post.where(user_id: nil).delete_all

    # Add foreign key constraint
    add_foreign_key :posts, :users

    # Make user_id non-nullable since we deleted all orphaned posts
    change_column_null :posts, :user_id, false
  end

  def down
    remove_reference :posts, :user, foreign_key: true
    remove_column :posts, :image_url
  end
end
