# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::SessionsController do
  describe 'POST #create' do
    subject! { post new_user_session_path, params: { user: { email: user.email, password: user.password } } }

    let!(:user) { create(:user, email: 'test@test.com') }

    context 'with successful login' do
      it { expect(response).to have_http_status(:created) }

      it 'returns a token' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns current user data' do
        expect(body_json).to eq(serialized_body('UserSerializer', user))
      end
    end

    context 'with wrong params' do
      let(:user) { instance_double(User, email: 'test@test.com', password: 'wrong') }

      it { expect(response).to have_http_status(:unauthorized) }

      it "doesn't return a token" do
        expect(response.headers['Authorization']).not_to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:session_delete) { delete destroy_user_session_path, headers: authenticated_header(user) }

    let!(:user) { create(:user, email: 'test@test.com', shopper: build(:shopper)) }

    it do
      session_delete

      expect(response).to have_http_status(:ok)
    end

    it do
      expect { session_delete }.to change(JwtDenylist, :count).by 1
    end

    context 'without a user logged' do
      subject(:session_delete) { delete destroy_user_session_path }

      it do
        session_delete

        expect(response).to have_http_status(:unauthorized)
      end

      it do
        expect { session_delete }.not_to change(JwtDenylist, :count)
      end
    end
  end
end
