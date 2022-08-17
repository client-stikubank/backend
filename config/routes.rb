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
      resources :carnivals
      resources :camps
      resources :stages, only: %i[index update]
      resources :stage_camps
      resources :stage_camp_schedules
      post '/login', to: 'login#create'
    end
  end
end
