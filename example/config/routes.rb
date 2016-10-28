Rails.application.routes.draw do
  devise_for :users
  resources :projects
  resources :project_assignments
  resources :phases
  resources :issues
  root to: 'projects#index'
end
