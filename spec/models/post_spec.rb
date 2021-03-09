require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:post) { user.posts.build(content: 'new post') }

  context 'Associations tests' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  it 'can create a new post' do
    expect(post.content).to eq('new post')
  end
end
