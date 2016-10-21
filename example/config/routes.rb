Rails.application.routes.draw do
  devise_for :users
  resources :projects
  resources :project_assignments
  resources :issues
  root to: 'projects#index'
end
