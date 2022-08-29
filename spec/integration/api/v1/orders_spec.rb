# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Orders API' do
  # rubocop: disable RSpec/VariableName
  let(:Authorization) { (authenticated_header(user)['Authorization']).to_s }
  let(:merchant) { create(:merchant) }
  let(:shopper) { create(:shopper) }
  let(:user) { shopper.user }

  let(:params) do
    {
      order: {
        merchant_id: merchant.id,
        amount: 20.54
      }
    }
  end

  path '/api/v1/orders/' do
    post('Create Order') do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          order: {
            type: :object,
            properties: {
              merchant_id: { type: :integer, example: 1 },
              amount: { type: :float, example: 20.52 }
            },
            required: %w[merchant_id amount]
          }
        },
        required: %w[order]
      }

      response 201, 'Creates Order' do
        examples 'application/json' => {
          status: 'ok',
          data: [
            {
              id: 72,
              amount: 25.22,
              status: 'pending',
              shopper: {
                id: 22,
                nif: 'NIF123456',
                created_at: '2022-08-28T08:54:48.360Z'
              },
              merchant: {
                id: 1,
                cif: 'CIF123456',
                created_at: '2022-08-28T01:23:11.622Z'
              }
            }
          ]
        }

        run_test! do |response|
          expect(response).to have_http_status(:created)
        end
      end

      response 422, 'Invalid params' do
        examples 'application/json' => {
          errors: {
            amount: [
              "can't be blank"
            ],
            merchant_id: [
              "can't be blank"
            ]
          }
        }

        xit
      end
    end
  end

  path '/api/v1/orders/{id}/complete' do
    post('Completes Order') do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :integer, required: true

      response 200, 'Completes Order' do
        xit
      end
    end
  end
end
