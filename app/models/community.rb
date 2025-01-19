# app/models/community.rb
class Community < ApplicationRecord
    validates :name, presence: true
    has_one_attached :image
end