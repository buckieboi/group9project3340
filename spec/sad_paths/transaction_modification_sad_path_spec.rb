# spec/sad_paths/transaction_modification_sad_path_spec.rb
require 'rails_helper'

RSpec.describe 'Transaction Modification - Sad Paths', type: :request do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user, amount: 50) }

  describe 'PUT /transactions/:id' do
    context 'when the transaction does not exist' do
      it 'returns a 404 error' do
        put '/transactions/999', params: { transaction: { amount: 100 } }
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)['error']).to eq('Transaction not found')
      end
    end

    context 'when the transaction belongs to another user' do
      it 'returns a 403 forbidden error' do
        other_user = create(:user)
        put "/transactions/#{transaction.id}", params: { transaction: { amount: 100 } }, headers: { 'X-User-Id' => other_user.id }
        expect(response.status).to eq(403)
        expect(JSON.parse(response.body)['error']).to eq('You are not authorized to modify this transaction')
      end
    end
  end

  describe 'DELETE /transactions/:id' do
    context 'when deleting a transaction that does not exist' do
      it 'returns a 404 error' do
        delete '/transactions/888'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)['error']).to eq('Transaction not found')
      end
    end
  end
end
