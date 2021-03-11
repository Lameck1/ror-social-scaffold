require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec.describe '/posts', type: :request do
  let(:user) do
    User.create!(name: 'test', email: 'test@test.com', password: '123456', encrypted_password: '123456',
                 gravatar_url: 'www.test.com')
  end
  let(:valid_attributes) do
    { 'user_id' => user.id, 'content' => 'Test' }
  end

  let(:invalid_attributes) do
    { 'username' => user.name, 'title' => 'Test' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Post.create! valid_attributes
      sign_in user
      get posts_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Post' do
        sign_in user
        expect do
          post posts_url, params: { post: valid_attributes }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the index page' do
        sign_in user
        post posts_url, params: { post: valid_attributes }
        expect(response).to redirect_to(posts_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Post' do
        expect do
          post posts_url, params: { post: invalid_attributes }
        end.to change(Post, :count).by(0)
      end
    end
  end
end
