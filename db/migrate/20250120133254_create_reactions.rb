class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :reaction_type, null: false

      t.timestamps
    end

    # Ensure a user can only have one reaction of each type per post
    add_index :reactions, [:user_id, :post_id, :reaction_type], unique: true, name: 'index_reactions_on_user_post_type'
  end
end
