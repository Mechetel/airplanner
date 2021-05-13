require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get "u/:username" => "profile#index", as: :profile

  root to: 'projects#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects

      resources :tasks do
        put :done,     on: :member
        put :sort,     on: :member
        put :deadline, on: :member
      end

      resources :comments, only: [:create, :destroy]

      resources :attachments, only: [:create]
    end
  end
end
