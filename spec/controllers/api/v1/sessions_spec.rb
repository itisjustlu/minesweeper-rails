require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  subject { FactoryBot.create(:user, email: 'lucas@gmail.com') }

  describe 'POST' do
    context 'when valid credents' do
      it 'returns token' do
        post :create, params: { email: subject.email, password: '123456' }
        expect(JSON.parse(response.body).dig('data', 'jwt')).to_not be_nil
      end

      it 'returns proper status' do
        post :create, params: { email: subject.email, password: '123456' }
        expect(response.status).to eq(200)
      end
    end

    context 'when invalid credentials' do
      it 'returns 422 as status' do
        post :create, params: { email: subject.email, password: '1234567' }
        expect(response.status).to eq(422)
      end
    end
  end
end