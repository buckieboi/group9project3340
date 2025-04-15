# spec/sad_paths/dashboard_sad_path_spec.rb
require 'rails_helper'

RSpec.describe 'Dashboard - Sad Paths', type: :request do
  describe 'GET /dashboard' do
    context 'when user is not logged in' do
      it 'returns a 401 unauthorized error' do
        get '/dashboard'
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['error']).to eq('User must be logged in')
      end
    end
  end

  describe 'POST /budget_reset' do
    let(:user) { create(:user) }

    context 'when there are no transactions to archive' do
      it 'returns a message stating nothing to archive' do
        post '/budget_reset', params: { user_id: user.id }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('No transactions to archive')
      end
    end
  end
end
