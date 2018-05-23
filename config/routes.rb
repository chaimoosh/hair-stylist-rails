Rails.application.routes.draw do


  resources :users do
    resources :appointments
  end
  resources :services
  resources :appointments
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/overdue_appointments', to: 'appointments#overdue_appointments'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get    '/login',   to: 'sessions#new'
  post   '/login', to: 'sessions#login'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: 'users#new'

end
