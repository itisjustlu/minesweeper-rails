require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should have_many :cells }
  it { should have_many :user_boards }
  it { should have_many :users }

  it { should validate_presence_of :rows }
  it { should validate_presence_of :columns }
  it { should validate_presence_of :mines }

  describe '.validations' do
    describe '.mines_length' do
      context 'when mines is greater than cells' do
        it 'returns invalid' do
          board = FactoryBot.build(:board, mines: 100, rows: 1, columns: 1)
          expect(board).to be_invalid
        end
      end

      context 'when mines is lower than cells' do
        it 'returns valid' do
          board = FactoryBot.build(:board, mines: 100, rows: 20, columns: 20)
          expect(board).to be_valid
        end
      end
    end
  end

  describe ".after_create" do
    let(:board) { FactoryBot.create(:board, rows: 10, columns: 10, mines: 12) }

    it 'generates cells' do
      expect { board }.to change { Cell.count }.by(100)
    end

    it 'generates mines' do
      expect { board }.to change { Cells::Mine.count }.by(12)
    end
  end
end
