class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :post_text
      t.boolean :has_image

      t.timestamps
    end
  end
end
