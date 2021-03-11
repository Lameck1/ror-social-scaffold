class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, -> { where(state: Friendship::CONFIRMED) }
  has_many :friends, through: :friendships

  has_many :friend_requests_sent, lambda {
                                    where(state: Friendship::REQUEST)
                                  }, class_name: 'Friendship', foreign_key: 'user_id'

  has_many :friend_requests_received, lambda {
                                        where(state: Friendship::REQUEST)
                                      }, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :friend_requests, through: :friend_requests_received, source: :user

  def friend?(user)
    friends.include?(user)
  end

  def mutual_friends(user)
    friends & user.friends
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end
end
