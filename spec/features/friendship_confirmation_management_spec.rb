require 'rails_helper'

RSpec.feature 'Send Friend Request Feature', type: :feature do
  let(:user_one) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }
  let(:user_two) { User.create(name: 'rosaliah', email: 'rosaliah@gmail.com', password: 'MyPass@133') }

  scenario 'Logged in user can accept friend request if any' do
    visit new_user_session_path

    fill_in 'Email', with: user_one.email
    fill_in 'Password', with: user_one.password

    click_button('Log in')

    visit user_path(user_two)

    click_link('Add Friend')

    click_link('Sign out')

    visit new_user_session_path

    fill_in 'Email', with: user_two.email
    fill_in 'Password', with: user_two.password

    click_button('Log in')

    visit user_path(user_one)

    click_link('Accept')

    expect(user_two.friend?(user_one)).to eql(true)
  end
end
