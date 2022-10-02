# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'swagger#index'

  # Swagger documentation
  scope :swagger, as: 'swagger' do
    get '/', to: 'swagger#index', as: :root
    get '/data', to: 'swagger#data', as: :data
  end

  draw :authentication

  defaults format: :json do
    namespace :admin do
      resources :camps
      resources :carnivals do
        member do
          post :activate
        end
      end
      resources :cities
      resources :coins, except: %i[create destroy]
      resources :stages, only: %i[index update]
      resources :stage_camps
      resources :stage_camp_schedules
      resources :permissions
      resources :provinces
      resources :refferals, only: %i[index show]
      resources :roles, only: %i[index show create]
      resources :users
      resources :user_stage_schedules
      resources :stocks do
        member do
          get :transactions
        end
      end
      post '/login', to: 'login#create'
    end
    namespace :api do
      namespace :v1 do
        resources :stages, only: :show
        resources :stage_camps, only: :show
        resources :user_stage_schedules, only: :create

        get '/active_carnival', to: 'carnivals#active_carnival'
      end
    end
    namespace :users do
      resources :user_profiles, only: %i[show update]
      put :update_password, path: '/:id/update_password', to: 'users#update_password'
    end
  end
end
