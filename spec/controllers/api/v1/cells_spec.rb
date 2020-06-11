require 'rails_helper'

RSpec.describe Api::V1::CellsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:board) { FactoryBot.create(:board, users: [user]) }
  let(:cell) { FactoryBot.create(:cell, board: board) }

  describe '.mark' do
    it 'marks cell' do
      request.headers.merge('Authorization' => authorization(user))
      expect { put :mark, params: { board_id: board.id, id: cell.id } }.to change {
        cell.reload.flag
      }.from('empty').to('mark')
    end
  end

  describe '.mark' do
    it 'marks cell' do
      request.headers.merge('Authorization' => authorization(user))
      expect { put :mark, params: { board_id: board.id, id: cell.id } }.to change {
        cell.reload.flag
      }.from('empty').to('mark')
    end
  end

  describe '.red' do
    it 'reds cell' do
      request.headers.merge('Authorization' => authorization(user))
      expect { put :red, params: { board_id: board.id, id: cell.id } }.to change {
        cell.reload.flag
      }.from('empty').to('red')
    end
  end

  describe '.restore' do
    before { cell.update(flag: :red) }
    it 'restores cell' do
      request.headers.merge('Authorization' => authorization(user))
      expect { put :restore, params: { board_id: board.id, id: cell.id } }.to change {
        cell.reload.flag
      }.from('red').to('empty')
    end
  end

  describe '.click' do
    before { cell.update(flag: :red) }
    it 'clicks cell' do
      request.headers.merge('Authorization' => authorization(user))
      expect { put :click, params: { board_id: board.id, id: cell.id } }.to change {
        cell.reload.clicked?
      }.from(false).to(true)
    end
  end
end