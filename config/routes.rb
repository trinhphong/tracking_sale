Rails.application.routes.draw do

  root 'dashboard#index'

  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions' }

  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }

  resources :tasks

  resources :outlets

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
