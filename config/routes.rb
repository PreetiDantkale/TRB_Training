Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'bill_amount', to: 'orders#bill_amount'
  resources :users
  resources :home
end
