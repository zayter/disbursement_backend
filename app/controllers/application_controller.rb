# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: { errors: error.record.errors.messages }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |_error|
    render json: { errors: 'We could not find the object you were looking for.' }, status: :not_found
  end

  rescue_from CanCan::AccessDenied do |error|
    render json: { errors: error&.message }, status: :unauthorized
  end

  rescue_from StandardAPIError do |error|
    render json: { message: error&.message, type: error.class, errors: error&.errors }, status: :bad_request
  end
end
