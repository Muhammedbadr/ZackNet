class AddUniqueIndexToCommunityUsers < ActiveRecord::Migration[7.2]
  def change
    add_index :community_users, [:user_id, :community_id], unique: true

  end
end
