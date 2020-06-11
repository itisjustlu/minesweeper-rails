require 'jwt'

def authorization(user)
  token = JWT.encode({ user_id: user.id }, 'minesweeper-rails')
  "Bearer #{token}"
end