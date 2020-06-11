require 'rails_helper'

RSpec.describe UserBoard, type: :model do
  it { should belong_to :user }
  it { should belong_to :board }
end
