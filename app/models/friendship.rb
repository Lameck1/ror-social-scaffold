class Friendship < ApplicationRecord
  enum state: {
    requesting: REQUESTING,
    accepted: ACCEPTED,
  }

  validates :state, presence: true

  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :requesting, -> { where(state: REQUESTING) }
  scope :accepted, -> { where(state: ACCEPTED) }
end
