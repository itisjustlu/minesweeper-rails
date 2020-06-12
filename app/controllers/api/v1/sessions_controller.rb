module Api
  module V1
    class SessionsController < BaseController
      def create
        @user = User.find_by!(email: params[:email])

        if @user.valid_password?(params[:password])
          render json: UserSerializer.new(@user).serializable_hash.deep_merge(data: {jwt: jwt_token})
        else
          render json: { data: { message: 'Invalid credentials' } }, status: 422
        end
      end
    end
  end
end