# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::RegistrationsController do
  describe 'POST #create' do
    subject(:post_create) { post user_registration_path, params: params, as: :json }

    let(:params) do
      {
        user: {
          email: 'test@test.com',
          password: 'Password123',
          password_confirmation: 'Password123',
          shopper_attributes: {
            nif: 'N123456'
          },
          merchant_attributes: {
            cif: 'C123456'
          }
        }
      }
    end

    context 'with successful user creation' do
      let(:user) { User.first }

      it do
        post_create

        expect(response).to have_http_status(:created)
      end

      it 'returns the Authorization token' do
        post_create

        expect(response.headers['Authorization']).to be_present
      end

      it 'creates an user', :aggregate_failures do
        expect { post_create }.to change(User, :count).by 1

        expect(user).to be_shopper
        expect(user.email).to eq params[:user][:email]
        expect(user.shopper.nif).to eq params.dig(:user, :shopper_attributes, :nif)
        expect(user.merchant.cif).to eq params.dig(:user, :merchant_attributes, :cif)
      end
    end

    context 'with wrong params' do
      let(:params) do
        {
          user: {
            email: 'test@test.com',
            password: 'Password123',
            password_confirmation: 'Password123',
            shopper_attributes: {
              nif: ''
            }
          }
        }
      end

      let(:expected_response) do
        {
          'shopper.nif' => ["can't be blank"],
          'shopper' => ['is invalid']
        }
      end

      it do
        post_create

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "doesn't returns the Authorization token" do
        post_create

        expect(response.headers['Authorization']).not_to be_present
      end

      it "doesn't create an user" do
        expect { post_create }.not_to change(User, :count)
      end

      it 'displays errors' do
        post_create

        expect(body_json['errors']).to eq expected_response
      end
    end
  end
end
