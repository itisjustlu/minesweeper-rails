module Api
  module V1
    class BoardsController < BaseController
      before_action :authenticate_user!
      before_action :find_board, only: [:show]

      def index
        @boards = current_user.boards.page(params[:page]).per(params[:per_page])
        render json: BoardSerializer.new(@boards).serialized_json
      end

      def create
        @board = current_user.boards.create(board_params)

        if @board.save
          @board.play!
          render json: serialized_board
        else
          render json: { errors: @board.errors.full_messages }
        end
      end

      def show
        render json: serialized_board
      end

      private

      def find_board
        @board = current_user.boards.find(params[:id])
      end

      def board_params
        params.permit(:rows, :columns, :mines)
      end

      def serialized_board
        BoardSerializer.new(@board, include: [:cells]).serialized_json
      end
    end
  end
end