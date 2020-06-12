module Api
  module V1
    class RegistrationsController < BaseController
      def create
        @user = User.new(user_params)

        if @user.save
          render json: UserSerializer.new(@user).serializable_hash.deep_merge(data: {jwt: jwt_token})
        else
          render json: { data: { errors: @user.errors.full_messages.first } }
        end
      end

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end