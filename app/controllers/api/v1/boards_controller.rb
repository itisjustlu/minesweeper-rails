module Api
  module V1
    class BoardsController < BaseController
      before_action :authenticate_user!
      before_action :find_board, only: [:show, :add_user]

      def index
        @boards = current_user.boards.order(id: :desc).page(params[:page]).per(params[:per_page])
        render json: BoardSerializer.new(@boards).serialized_json
      end

      def create
        @board = current_user.boards.create(board_params)

        if @board.save
          @board.play!
          render json: serialized_board
        else
          render json: { errors: @board.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: serialized_board
      end

      def add_user
        @user = User.find_by!(email: params[:email])
        @board.users << @user
        render status: :ok
      end

      private

      def find_board
        @board = current_user.boards.find(params[:id])
      end

      def board_params
        params.permit(:rows, :columns, :mines)
      end

      def serialized_board
        BoardSerializer
          .new(@board, include: [:users])
          .serializable_hash
          .merge(
            cells: @board.cells
                     .order(row: :asc)
                     .order(column: :asc)
                     .group_by(&:row).map{ |_k, v| CellSerializer.new(v).serializable_hash }
          )
      end
    end
  end
end