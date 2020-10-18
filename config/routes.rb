require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins
  put '/students/change_money', to: 'students#change_money', as: 'change_money'
  resources :students
  resources :grades
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
