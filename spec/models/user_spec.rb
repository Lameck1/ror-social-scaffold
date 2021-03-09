require 'rails_helper'

RSpec.describe User, type: :model do
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
end
