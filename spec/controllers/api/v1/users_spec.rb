require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe '.me' do
    it 'returns user' do
      request.headers.merge('Authorization' => authorization(user))
      get :me
      expect(JSON.parse(response.body)['data']['id']).to eq(user.id.to_s)
    end
  end
end
