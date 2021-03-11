require 'rails_helper'
require 'devise'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec.describe '/users', type: :request do
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { 'name' => 'test', 'email' => 'test@test.com', 'password' => '123456', 'encrypted_password' => '123456',
      'gravatar_url' => 'www.test.com' }
  end

  let(:invalid_attributes) do
    { 'surname' => 'test', 'address' => 'test@test.com', 'passkey' => '123456', 'asd' => '123456',
      'dddd' => 'www.test.com' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      sign_in user
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_registration_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      user = User.create! valid_attributes
      sign_in user
      get edit_user_registration_url(user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post users_url, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end
    end
  end
end
