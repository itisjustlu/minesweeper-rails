class Cell < ApplicationRecord
  belongs_to :board

  validates :row, presence: true
  validates :column, presence: true

  enum flag: {
    empty: 0,
    mark: 1,
    red: 2
  }

  def click!

    return unless can_click?
    update(clicked: true)
    update_adjacents!(adjacents) if mines_around.to_i.zero? && board.playing?
    check_game_status!
  end

  def mark!
    return unless can_click?
    update(flag: :mark)
  end

  def red_flag!
    return unless can_click?
    update(flag: :red)
  end

  def restore_flag!
    return unless can_click?
    update(flag: :empty)
  end

  def can_click?
    !clicked?
  end

  def check_game_status!
    none_cells = board.cells.where(type: "Cells::None")
    remaining = none_cells.count - none_cells.where(clicked: true).count
    board.win! if remaining.zero?
  end

  def adjacents
    @adjacents ||= board.cells.where(row: row + 1, column: column)
      .or(board.cells.where(row: row + 1, column: column + 1))
      .or(board.cells.where(row: row, column: column + 1))
      .or(board.cells.where(row: row - 1, column: column + 1))
      .or(board.cells.where(row: row - 1, column: column))
      .or(board.cells.where(row: row - 1, column: column - 1))
      .or(board.cells.where(row: row, column: column - 1))
      .or(board.cells.where(row: row + 1, column: column - 1))
  end

  def update_adjacents!(cells)
    cells.update_all(clicked: true)
  end
end
