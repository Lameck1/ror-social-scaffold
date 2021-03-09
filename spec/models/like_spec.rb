require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user_one) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:user_two) { User.create(name: 'rosaliah', email: 'rosaliah@gmail.com', password: 'MyPass@133') }
  let(:post) { user_one.posts.create!(content: 'new post') }

  context 'Associations tests' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  it 'ensures a like is created by a user' do
    expect { post.likes.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can create a new like record' do
    like = post.likes.create!(user_id: user_two.id)
    expect(post.likes).to eq([like])
  end
end
