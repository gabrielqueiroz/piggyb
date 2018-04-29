Rails.application.routes.draw do

  root to: 'logins#new'

  resources :users
  resources :logins
end
