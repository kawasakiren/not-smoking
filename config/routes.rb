Rails.application.routes.draw do
  get 'users/new'
  get 'users/index'
  get 'users/show'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'toppages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :create, :edit, :update]
end
