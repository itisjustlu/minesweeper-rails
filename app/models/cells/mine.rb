module Cells
  class Mine < ::Cell
    def click!
      super
      board.lose!
    end
  end
end
