Rails.application.routes.draw do

  root 'dashboard#index'

  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions' }

  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }

  resources :tasks

  resources :outlets

  post '/api/sign_in', to: "api/sessions#create", as: :api_sign_in
  post '/api/check_in', to: "api/locations#check_in", as: :api_check_in
  post '/api/check_out', to: "api/locations#check_out", as: :api_check_out

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
