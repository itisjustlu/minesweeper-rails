module Cells
  class Mine < ::Cell
    def click!
      return unless can_click?
      update(clicked: true)
      board.lose!
    end
  end
end
