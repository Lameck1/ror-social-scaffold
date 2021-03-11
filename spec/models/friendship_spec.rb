require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user_one) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:user_two) { User.create(name: 'rosaliah', email: 'rosaliah@gmail.com', password: 'MyPass@133') }

  describe 'ActiveRecord associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  it 'can create a friend request' do
    user_one.friendships.create(user_id: user_one.id, friend_id: user_two.id, state: Friendship::REQUEST)
    expect(user_two.friend_requests.include?(user_one)).to eql(true)
  end

  it 'can check if user_one is a friend to user_two and vice-versa' do
    user_one.friendships.create!(user_id: user_one.id, friend_id: user_two.id, state: Friendship::CONFIRMED)
    user_two.friendships.create(user_id: user_two.id, friend_id: user_one.id, state: Friendship::CONFIRMED)
    expect(user_two.friend?(user_one)).to eql(true)
    expect(user_one.friend?(user_two)).to eql(true)
  end
end
