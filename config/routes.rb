Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  to: 'home#index'

  resources :user_accounts, only: [:index, :show]
  resources :team_accounts, only: [:index, :show]
  resources :stock_accounts, only: [:index, :show]
  resources :transactions
end
