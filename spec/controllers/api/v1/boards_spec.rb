require 'rails_helper'

RSpec.describe Api::V1::BoardsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe '.index' do
    let!(:boards) { FactoryBot.create_list(:board, 3, users: [user]) }

    it 'returns boards' do
      request.headers.merge('Authorization' => authorization(user))
      get :index, params: { per_page: 2 }
      expect(JSON.parse(response.body)['data'].count).to eq(2)
    end
  end

  describe '.show' do
    let!(:board) { FactoryBot.create(:board, users: [user]) }

    it 'returns board' do
      request.headers.merge('Authorization' => authorization(user))
      get :show, params: { id: board.id }
      expect(JSON.parse(response.body).dig('data', 'attributes', 'id')).to eq(board.id)
    end
  end

  describe '.create' do
    it 'creates board' do
      request.headers.merge('Authorization' => authorization(user))
      expect { post :create, params: { rows: 2, columns: 2, mines: 1 } }.to change{ Board.count }.by(1)
    end
  end
end
