require 'rails_helper'

RSpec.describe Cells::Mine, type: :model do
  let(:board) { FactoryBot.create(:board, state: :playing) }
  subject { FactoryBot.create(:cell, type: 'Cells::Mine', board: board) }

  describe '.click' do
    it 'changes board state to lost' do
      cell = Cell.find(subject.id) # factorybot type issue
      expect { cell.click! }.to change { board.reload.state }.from('playing').to('lost')
    end
  end
end
