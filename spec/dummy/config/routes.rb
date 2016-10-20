Rails.application.routes.draw do
  devise_for :users
  resources :projects
  resources :issues
  root to: 'projects#index'
end
