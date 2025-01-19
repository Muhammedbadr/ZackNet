class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
validates :name, presence: true, length: { minimum: 2, maximum: 50 }

has_many :posts
has_one_attached :avatar
has_many :relationships , foreign_key: "followed_id" 
has_many :reposts
# has_many :delete
has_many :following, class_name: "Relationship" , foreign_key: "follower_id"
has_many :followers, class_name: "Relationship" , foreign_key: "followed_id"


end
