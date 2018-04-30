Rails.application.routes.draw do

  root to: 'logins#new'

  resources :users
  resources :piggy_banks do
    resource :movements
  end

  get '/', to: 'logins#new', as: 'new_login'
  post '/login', to: 'logins#create', as: 'create_login'
  get '/logout', to: 'logins#destroy', as: 'destroy_login'
end
