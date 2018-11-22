Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, path_prefix: 'oauth'
  resources :users
  resources :videos
end
