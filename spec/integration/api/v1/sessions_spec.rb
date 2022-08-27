# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Sessions API' do
  path '/api/v1/users/sign_up' do
    post('Sign up user') do
      tags 'Sessions & Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'john@test.com' },
              password: { type: :string, example: 'Password123?' },
              password_confirmation: { type: :string, example: 'Password123?' },
              shopper_attributes: {
                type: :object,
                properties: {
                  nif: { type: :string, example: 'NIF123456' }
                }
              },
              merchant_attributes: {
                type: :object,
                properties: {
                  cif: { type: :string, example: 'CIF123456' }
                }
              }

            },
            required: %w[email password password_confirmation]
          }
        },
        required: %w[user]
      }

      response 201, 'Signs up user' do
        xit
      end

      response 422, 'Invalid params' do
        examples 'application/json' => {
          errors: {
            password: [
              "can't be blank"
            ],
            email: [
              "can't be blank"
            ]
          }
        }

        xit
      end
    end
  end

  path '/api/v1/users/sign_in' do
    post('Sign in user') do
      tags 'Sessions & Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'john@test.com' },
              password: { type: :string, example: 'Password123?' }
            },
            required: %w[email password]
          }
        },
        required: %w[user]
      }

      response 201, 'signs in user' do
        examples 'application/json' => {
          id: 1,
          email: 'example@shopper.com',
          created_at: '2022-07-28T19:12:33.589Z',
          shopper: {
            id: 1,
            nif: 'NIF123456',
            created_at: '2022-07-28T19:12:33.589Z'
          },
          merchant: {
            id: 1,
            cif: 'CIF123456',
            created_at: '2022-07-28T19:12:33.589Z'
          }
        }

        xit
      end

      response 401, 'invalid credentials' do
        xit
      end
    end
  end

  path '/api/v1/users/sign_out' do
    delete('Sign out user') do
      tags 'Sessions & Auth'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      response 200, 'signs out user' do
        xit
      end

      response 401, 'unauthorized request' do
        examples 'application/json' => {
          error: 'You need to sign in or sign up before continuing.'
        }

        xit
      end
    end
  end
end
