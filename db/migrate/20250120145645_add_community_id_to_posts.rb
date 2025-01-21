class AddCommunityIdToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :community, null: true, foreign_key: true
  end
end
