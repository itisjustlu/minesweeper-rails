module Api
  module V1
    class CellsController < BaseController
      before_action :authenticate_user!
      before_action :find_board
      before_action :find_cell, only: %i[mark red restore click]
      
      def mark
        @cell.mark!
        render status: :ok
      end
      
      def red
        @cell.red_flag!
        render status: :ok
      end
      
      def restore
        @cell.restore_flag!
        render status: :ok
      end
      
      def click
        @cell.click!
        render status: :ok
      end
      
      private
      
      def find_board
        @board = current_user.boards.find(params[:board_id])
      end
      
      def find_cell
        @cell = @board.cells.find(params[:id])
      end
    end
  end
end