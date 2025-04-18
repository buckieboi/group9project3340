Rails.application.routes.draw do
  # Auth routes
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Transactions
  resources :transactions, only: [:create, :update, :destroy]

  # Budget reset
  post 'budget_reset', to: 'users#budget_reset'
end
