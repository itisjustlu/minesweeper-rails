class Board < ApplicationRecord
  has_many :cells
  has_many :user_boards
  has_many :users, through: :user_boards
end
