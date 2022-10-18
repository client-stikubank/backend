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
      resources :user_profiles, only: %i[show update]
      resources :users
      resources :user_stage_schedules
      resources :gifts
      resources :carnival_gifts
      resources :user_carnival_gifts, only: %i[index show]
      resources :stocks do
        member do
          get :transactions
        end
      end
      post '/login', to: 'login#create'

      put :update_password, path: '/:id/update_password', to: 'users#update_password'
    end
    namespace :api do
      namespace :v1 do
        resources :cities, only: :index
        resources :provinces, only: :index
        resources :stages, only: :show
        resources :stage_camps, only: :show
        resources :user_stage_schedules, only: :create
        resources :carnival_gifts, only: %i[index show]

        get :display_profile, path: '/display_profile', to: 'user_profiles#display_profile'
        put :update_profile, path: '/update_profile', to: 'user_profiles#update_profile'
        put :update_password, path: '/update_password', to: 'users#update_password'
        get '/active_carnival', to: 'carnivals#active_carnival'
        put '/active_camp/confirm', to: 'carnivals#confirm_active_camp'
        put '/active_camp/claim', to: 'carnivals#claim_active_camp'
      end
    end
  end
end
