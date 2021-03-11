require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
  let(:user) { User.create(name: 'lameck', email: 'lameck72@gmail.com', password: 'MyPass@123') }

  scenario 'Cannot visit timeline if user is not logged in' do
    visit users_path

    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'Can visit timeline if user is logged in' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button('Log in')

    expect(page).to have_current_path(root_path)
  end
end
