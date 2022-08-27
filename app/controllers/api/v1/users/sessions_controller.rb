# frozen_string_literal: true

module API
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_to_on_destroy
          current_user ? log_out_success : log_out_failure
        end

        def log_out_success
          render status: :ok
        end

        def log_out_failure
          render status: :unauthorized
        end
      end
    end
  end
end
