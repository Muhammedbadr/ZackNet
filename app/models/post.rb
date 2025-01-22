class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes
  has_many :comments
  has_many :reposts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reposts, dependent: :destroy

end
