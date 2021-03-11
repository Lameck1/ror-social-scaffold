class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  STATES = [
    REQUEST = 'request'.freeze,
    CONFIRMED = 'confirmed'.freeze
  ].freeze

  def confirm_friend
    update_attributes(state: CONFIRMED)
    Friendship.create!(user_id: friend_id, friend_id: user_id, state: CONFIRMED)
  end

  def unfriend
    Friendship.find_by(user_id: friend_id, friend_id: user_id).destroy if destroy
  end
end
