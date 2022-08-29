# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount Sidekiq::Web => '/sidekiq'

  Healthcheck.routes(self)

  devise_for :users,
             defaults: { format: :json },
             path: 'api/v1/users',
             path_names: {
               sign_in: 'sign_in',
               sign_out: 'logout',
               registration: 'sign_up'
             },
             controllers: {
               sessions: 'api/v1/users/sessions',
               registrations: 'api/v1/users/registrations'
             }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders, only: %i[create] do
        member do
          post 'complete'
        end
      end

      resources :disbursements, only: %i[index]
    end
  end
end
