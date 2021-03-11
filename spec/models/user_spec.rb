require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_one) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:user_two) { User.create(name: 'rosaliah', email: 'rosaliah@gmail.com', password: 'MyPass@133') }

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:friend_requests_sent) }
    it { should have_many(:friend_requests_received) }
    it { should have_many(:friend_requests).through(:friend_requests_received) }
  end

  context 'Qurrying for friendship' do
    describe 'friendship status' do
      it 'checks if users are friends' do
        user_one.friendships.create(user_id: user_one.id, friend_id: user_two.id, state: Friendship::CONFIRMED)
        expect(user_one.friend?(user_two)).to eql(true)
      end

      it 'checks for existance of friend requests' do
        user_one.friendships.create(user_id: user_one.id, friend_id: user_two.id, state: Friendship::REQUEST)
        expect(user_two.friend_requests.include?(user_one)).to eql(true)
      end
    end
  end
end
