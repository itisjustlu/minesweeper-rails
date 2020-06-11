require 'jwt'

module Api
  module V1
    class BaseController < ActionController::API
      # we can set this in secrets.yml...
      def secret
        'minesweeper-rails'
      end

      def authenticate_user!
        begin
          token = request.headers['Authorization'].to_s.gsub(/^Bearer /, '')
          payload = JWT.decode(token, secret).first
          @current_user = User.find(payload['user_id'])
        rescue
          render json: { data: { message: 'Unauthorized' } }, status: 401
        end

      end

      def current_user
        @current_user
      end
    end
  end
end