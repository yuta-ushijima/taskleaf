Rails.application.routes.draw do
  namespace :admin do
    resoutces :users
  end

  root to: 'tasks#index'
  resources :tasks
end
