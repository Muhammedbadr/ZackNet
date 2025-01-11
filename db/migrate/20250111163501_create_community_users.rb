# db/migrate/20250111163501_create_community_users.rb
class CreateCommunityUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :community_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
