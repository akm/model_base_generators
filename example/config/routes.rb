Rails.application.routes.draw do
  resources :issue_comments
  devise_for :users
  resources :projects
  resources :project_assignments
  resources :phases
  resources :issues
  root to: 'projects#index'
end
