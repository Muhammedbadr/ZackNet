# app/models/community.rb
class Community < ApplicationRecord
    has_one_attached :image
    validates :name, presence: true
    has_many :community_users
    has_many :users , through: :community_users
    has_many :posts
    belongs_to :community
end