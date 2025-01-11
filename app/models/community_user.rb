# app/models/community_user.rb
class CommunityUser < ApplicationRecord
  belongs_to :user
  belongs_to :community
end
