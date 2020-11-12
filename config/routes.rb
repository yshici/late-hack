Rails.application.routes.draw do
  resource :proof_of_delays, only: %i[new create show]
  resources :users, only: %i[new create destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :schedules
  root 'home#index'
end
