require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      email: 'danie@example.com',
      password: 'supersecurepassword',
      password_confirmation: 'supersecurepassword',
    )
  end

  let(:another_user) do
    User.create(
      email: 'john@example.com',
      password: 'securepassword',
      password_confirmation: 'securepassword',
    )
  end

  describe 'GET /index' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /archive' do
    it 'returns http ok' do
      auth_token = authenticate_user(user)
      post archive_user_path(another_user), headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /unarchive' do
    it 'returns http ok' do
      auth_token = authenticate_user(user)
      post unarchive_user_path(another_user), headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /archive' do
    it 'returns http unprocessable_entity' do
      auth_token = authenticate_user(user)
      post archive_user_path(user), headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /unarchive' do
    it 'returns http unprocessable_entity' do
      auth_token = authenticate_user(user)
      post unarchive_user_path(user), headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
