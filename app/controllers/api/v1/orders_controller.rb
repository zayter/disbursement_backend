# frozen_string_literal: true

module API
  module V1
    class OrdersController < ApplicationController
      load_resource :shopper, through: :current_user, singleton: true, only: :create
      load_resource :merchant, through: :current_user, singleton: true, only: :complete
      load_and_authorize_resource through: :shopper, only: :create
      load_and_authorize_resource through: :merchant, only: :complete

      def create
        @order.save!
        render json: { data: OrderSerializer.new(@order) }, status: :created
      end

      def complete
        @order.complete
        @order.save
        render json: { data: OrderSerializer.new(@order) }, status: :created
      end

      private

      def order_params
        params.require(:order).permit(
          :merchant_id,
          :amount
        )
      end
    end
  end
end
