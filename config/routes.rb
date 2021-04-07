Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :create, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  
  resources :posts, only: [:new, :create, :destroy, :edit, :update]
end
