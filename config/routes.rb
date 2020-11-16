require 'sidekiq/web'

Rails.application.routes.draw do
  resources :notifications
  get '/delete_admin_notifications', to: 'notifications#delete_admin_notifications', as: 'delete_admin_notifications'
  get '/read_notifications', to: 'notifications#read_notifications', as: 'read_notifications'
  resources :events
  resources :volunteers
  resources :stands
  resources :departments
  resources :jobs
  devise_for :admins
  put '/students/change_money', to: 'students#change_money', as: 'change_money'
  resources :students
  resources :grades
  get '/about', to: 'home#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
