Rails.application.routes.draw do
  resource :proof_of_delays, only: %i[new create show]
  root 'home#index'
end
