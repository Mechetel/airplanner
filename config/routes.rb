require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  get "u/:username" => "profile#index", as: :profile

  root to: 'projects#index'

  resources :projects
end
