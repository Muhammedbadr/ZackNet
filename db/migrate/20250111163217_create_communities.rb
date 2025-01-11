# db/migrate/20250111163217_create_communities.rb
class CreateCommunities < ActiveRecord::Migration[7.2]
  def change
    create_table :communities do |t|
      t.string :name

      t.timestamps
    end
  end
end
