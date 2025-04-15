# spec/sad_paths/authentication_sad_path_spec.rb
require 'rails_helper'

RSpec.describe 'Authentication - Sad Paths', type: :request do
  describe 'POST /signup' do
    context 'when required fields are missing' do
      it 'returns a 422 error for missing email' do
        post '/signup', params: { user: { password: 'password123' } }
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to include("Email can't be blank")
      end
    end

    context 'when the email is already taken' do
      it 'returns a 409 conflict error' do
        existing_user = create(:user, email: 'test@example.com')
        post '/signup', params: { user: { email: 'test@example.com', password: 'password123' } }
        expect(response.status).to eq(409)
        expect(JSON.parse(response.body)['error']).to eq('Email already exists')
      end
    end
  end

  describe 'POST /login' do
    context 'when credentials are invalid' do
      it 'returns an error message and does not create a session' do
        post '/login', params: { email: 'wrong@example.com', password: 'badpassword' }
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end
end
