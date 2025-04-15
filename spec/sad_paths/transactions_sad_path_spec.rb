# spec/sad_paths/transactions_sad_path_spec.rb
require 'rails_helper'

RSpec.describe 'Transactions - Sad Paths', type: :request do
  let(:user) { create(:user, balance: 100) }

  describe 'POST /transactions for withdrawal' do
    context 'when withdrawal exceeds available balance' do
      it 'returns a 422 error and does not process the transaction' do
        post '/transactions', params: {
          transaction: {
            amount: 150,
            transaction_type: 'withdrawal'
          },
          user_id: user.id
        }

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient funds')
        user.reload
        expect(user.balance).to eq(100)
      end
    end

    context 'when invalid transaction type is provided' do
      it 'returns a 422 error with an appropriate message' do
        post '/transactions', params: {
          transaction: {
            amount: 50,
            transaction_type: 'magic'
          },
          user_id: user.id
        }

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('Invalid transaction type')
        user.reload
        expect(user.balance).to eq(100)
      end
    end
  end
end
