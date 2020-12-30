Rails.application.routes.draw do
  namespace :admin do
      resources :excuses
      resources :schedules
      resources :excuse_schedules
      resources :users

      root to: "excuses#index"
    end
  resource :temporary_schedules, only: %i[new create show]
  resources :users, only: %i[new create show edit update]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :schedules, shallow: true do
    resources :results, only: %i[show]
  end
  root 'home#index'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
