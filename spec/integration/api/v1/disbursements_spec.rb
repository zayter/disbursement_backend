# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Disbursement API' do
  path '/api/v1/disbursements/' do
    get('Disbursement List') do
      tags 'Disbursement'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :week, in: :query, type: :integer, example: '50', required: true
      parameter name: :merchant_id, in: :query, type: :integer, example: '1', required: false

      response 200, 'Disbursement List for given Merchant' do
        xit
      end

      response 422, 'Invalid params' do
        examples 'application/json' => {
          errors: {
            week: [
              "can't be blank"
            ]
          }
        }

        xit
      end
    end
  end
end
