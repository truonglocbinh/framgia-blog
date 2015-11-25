Rails.application.routes.draw do
  root 'static_pages#home'
  get    'signup'       => 'users#new'
  get    'login'		    => 'sessions#new'
  post   'login'		    => 'sessions#create'
  delete 'logout'       => 'sessions#destroy'
  resources :comments
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :entries do
    member do
      post :all_comment
    end
  end
end
