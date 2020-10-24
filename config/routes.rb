Rails.application.routes.draw do
  resources :proof_of_delay, only: %i[new create show]
end
