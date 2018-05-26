Rails.application.routes.draw do

  root 'dashboard#index'

  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions', registrations: "users/registrations" }

  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }

  resources :tasks

  resources :outlets

  resources :products

  post '/api/sign_in', to: "api/sessions#create", as: :api_sign_in
  post '/api/check_in', to: "api/locations#check_in", as: :api_check_in
  post '/api/check_out', to: "api/locations#check_out", as: :api_check_out
  post '/api/sale', to: "api/sale#save_sale", as: :api_sale
  post '/api/get_outlets', to: "api/sale#get_outlets", as: :api_get_outlets
  post '/api/sell', to: "api/sale#sell", as: :api_sell
  post '/api/info', to: "api/sessions#info_staff", as: :api_info

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
