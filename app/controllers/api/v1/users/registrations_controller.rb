# frozen_string_literal: true

module API
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include RackSessionFix
        before_action :configure_permitted_parameters

        respond_to :json

        private

        def respond_with(resource, _opts = {})
          resource.persisted? ? register_success : register_failed(resource)
        end

        def register_success
          render status: :created
        end

        def register_failed(resource)
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up,
                                            keys: [
                                              { shopper_attributes: %i[nif] },
                                              { merchant_attributes: %i[cif] }
                                            ])
        end
      end
    end
  end
end
