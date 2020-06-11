require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :user_boards }
  it { should have_many :boards }
end