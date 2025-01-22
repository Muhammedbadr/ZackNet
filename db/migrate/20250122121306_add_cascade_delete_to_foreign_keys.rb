class AddCascadeDeleteToForeignKeys < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :comments, :posts
    add_foreign_key :comments, :posts, on_delete: :cascade

    remove_foreign_key :likes, :posts
    add_foreign_key :likes, :posts, on_delete: :cascade

    remove_foreign_key :reposts, :posts
    add_foreign_key :reposts, :posts, on_delete: :cascade
  end
end
