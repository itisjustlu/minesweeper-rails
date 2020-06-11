module Api
  module V1
    class SessionsController < BaseController
      def create
        @user = User.find_by(email: params[:email])

        if @user.valid_password?(params[:password])
          render json: { data: { token: jwt_token } }
        else
          render json: { data: { message: 'Invalid credentials' } }, status: 422
        end
      end

      private

      def jwt_token
        JWT.encode({ user_id: @user.id }, secret)
      end
    end
  end
end