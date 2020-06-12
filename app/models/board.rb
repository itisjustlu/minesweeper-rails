class Board < ApplicationRecord
  include AASM

  has_many :cells
  has_many :user_boards
  has_many :users, through: :user_boards

  validates :rows, presence: true
  validates :columns, presence: true
  validates :mines, presence: true
  validate :mines_length

  after_commit :generate_cells, on: :create

  aasm column: :state do
    state :created, initial: true
    state :playing, :lost, :won

    event :play do
      transitions from: :created, to: :playing
    end

    event :win do
      transitions from: :playing, to: :won, after: proc { update(finished_at: Time.now) }
    end

    event :lose do
      transitions from: :playing, to: :lost, after: proc { update(finished_at: Time.now) }
    end
  end

  private

  def mines_length
    errors.add(:mines, 'cant be greater or equal than total cells') if mines.to_i >= rows.to_i * columns.to_i
    errors.add(:mines, 'cant be zero') if mines.to_i.zero?
  end

  def generate_cells
    ApplicationRecord.transaction do
      create_cells
      set_mines
      set_number_to_cells
    end
  end

  def create_cells
    rows.times do |row|
      columns.times do |column|
        cells.create(type: Cells::None, row: row, column: column, flag: :empty)
      end
    end
  end

  def set_mines
    cells.order("RANDOM()").limit(mines).update_all(type: Cells::Mine)
  end

  # we can calculate this dyncamically, but it's better to have it on create
  # method to avoid performance issues
  def set_number_to_cells
    mine_cells = cells.where(type: 'Cells::Mine')

    cells.where(type: 'Cells::None').find_each do |cell|
      mines_around = mine_cells
        .where(row: cell.row + 1, column: cell.column)
        .or(mine_cells.where(row: cell.row + 1, column: cell.column + 1))
        .or(mine_cells.where(row: cell.row, column: cell.column + 1))
        .or(mine_cells.where(row: cell.row - 1, column: cell.column + 1))
        .or(mine_cells.where(row: cell.row - 1, column: cell.column))
        .or(mine_cells.where(row: cell.row - 1, column: cell.column - 1))
        .or(mine_cells.where(row: cell.row, column: cell.column - 1))
        .or(mine_cells.where(row: cell.row + 1, column: cell.column - 1))
        .count

      cell.update(mines_around: mines_around)
    end
  end
end
