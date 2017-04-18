Rails.application.routes.draw do
  get 'users/new'

  get 'sessions/new'

  root to: 'application#landing'

  resources :creatures, only: [:index, :show]
  resources :categories, only: [:index]
  resources :orders, only: [:index, :show, :create, :update]
  resource :cart, only: [:show, :create, :update, :destroy]
  resources :users, only: [:new, :create]

  namespace :admin do
    get '/dashboard', to: 'users#show'
    get '/dashboard/edit', to: 'users#edit', as: 'edit'
    put '/dashboard/update', to: 'users#update', as: 'update'
    get '/users', to: 'users#index', as: 'users'
    get '/orders', to: 'orders#index', as: 'orders'
    put '/order/:id', to: 'orders#update', as: 'order'
    resources :creatures, except: [:destroy]
  end

  get '/dashboard', to: 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/:category', to: 'categories#show', as: 'category'
end
