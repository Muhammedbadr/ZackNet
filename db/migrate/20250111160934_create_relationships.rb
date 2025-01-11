class CreateRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_foreign_key :relationships, :users, column: :followed_id
    add_foreign_key :relationships, :users, column: :follower_id
  end
end
