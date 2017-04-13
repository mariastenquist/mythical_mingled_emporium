Rails.application.routes.draw do
  root to: 'creatures#index'

  resources :creatures, only: [:index, :show]
  resources :categories, only: [:index]
  resources :orders, only: [:index, :show]
  resource :cart, only: [:show, :create, :update, :destroy]

  get '/:category', to: 'categories#show', as: 'category'
end
