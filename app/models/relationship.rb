class Relationship < ApplicationRecord
    validates :follower_id, uniqueness: { scope: :followed_id }
end
