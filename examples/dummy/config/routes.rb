Rails.application.routes.draw do
  devise_for :users
  # root to: "devise/sessions#new" # Sign in
  root to: "rails_admin/main#dashboard" # TODO Change top page


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
