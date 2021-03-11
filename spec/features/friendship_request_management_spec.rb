require 'rails_helper'

RSpec.feature 'Send Friend Request Feature', type: :feature do
  let(:user_one) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:user_two) { User.create(name: 'rosaliah', email: 'rosaliah@gmail.com', password: 'MyPass@133') }

  scenario 'Cannot send friend request if user is not logged in' do
    visit users_path

    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'Friendship will be sent if a user is logged in' do
    visit new_user_session_path

    fill_in 'Email', with: user_one.email
    fill_in 'Password', with: user_one.password

    click_button('Log in')

    visit user_path(user_two)

    click_link('Add Friend')

    expect(user_two.friend_requests.include?(user_one)).to eql(true)
  end
end
