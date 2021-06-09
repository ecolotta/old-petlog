Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create update destroy]
      resources :dogs, only: %i[create update destroy]
      get 'me', to: 'users#me'
      get 'token', to: 'users#token'
      get 'sign_out', to: "sessions#destroy"
      devise_for :users, controllers: {omniauth_callbacks: "api/v1/auth/omniauth_callbacks"}
    end
  end
  post '/webhook' => 'linebot#webhook'
  resources :linebot
  get '*path', to: 'home#index', constraints: lambda { |req|
    # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
    req.path.exclude? 'rails/active_storage'
  }
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
