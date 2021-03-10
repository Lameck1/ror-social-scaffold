require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }

  it 'ensures that comment is not blank' do
    post = user.posts.new(content: 'Just checked in at Hilton!')
    post1 = user.posts.new(content: nil)
    expect(post).to be_valid
    expect(post1).not_to be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
