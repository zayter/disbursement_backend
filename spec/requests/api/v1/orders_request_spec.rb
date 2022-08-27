# frozen_string_literal: true

require 'rails_helper'

describe API::V1::OrdersController do
  describe 'POST #create' do
    subject(:post_create) do
      post api_v1_orders_path, params: params, headers: authenticated_header(user), as: :json
    end

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

    it do
      post_create
      expect(response).to have_http_status :created
    end

    it 'creates an order', :aggregate_failures do
      expect { post_create }.to change(Order, :count).by 1
    end

    include_examples 'unauthorized'
  end

  describe 'POST #complete' do
    subject(:post_create) do
      post complete_api_v1_order_path(order.id), headers: authenticated_header(user), as: :json
    end

    let(:merchant) { create(:merchant) }
    let(:shopper) { create(:shopper) }
    let(:order) { create(:order, merchant: merchant, shopper: shopper) }
    let(:user) { merchant.user }

    it do
      post_create
      expect(response).to have_http_status :created
    end

    it 'creates an order', :aggregate_failures do
      expect { post_create }.to change(Order, :count).by 1
    end

    include_examples 'unauthorized'
  end
end
