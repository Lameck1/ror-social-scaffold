class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  STATES = [
    REQUEST = 'request'.freeze,
    CONFIRMED = 'confirmed'.freeze
  ].freeze
end
