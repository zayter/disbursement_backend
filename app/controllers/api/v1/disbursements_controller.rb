# frozen_string_literal: true

module API
  module V1
    class DisbursementsController < ApplicationController
      before_action :authenticate_user!

      def index
        authorize! :read, Disbursement
        render json: { data: ActiveModelSerializers::SerializableResource.new(disbursements) }
      end

      private

      def disbursements
        result = Disbursement.where(week: params['week'])
        result = result.where(merchant_id: params['merchant_id']) if params['merchant_id'].present?
        result
      end
    end
  end
end
