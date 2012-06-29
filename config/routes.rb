Hn::Application.routes.draw do
  resources :articles do
    resources :comments
    get :vote
  end
  
  resources :comments do
    resources :comments
    get :vote
  end
  
  resources :users, :except => [:destroy, :edit]
  resources :sessions, :only => [:new, :create, :destroy]
  resource :password_resets

  root :to => 'articles#index'
  match '/login',           :to => 'sessions#new'
  match '/logout',          :to => 'sessions#destroy', via: :delete
  match '/signup',          :to => 'users#new'
  match '/change_password', :to => 'users#password'
  match '/reset_password',  :to => 'password_resets#new'
  match '/about',           :to => 'pages#about'
  match '/:duration',       :to => 'articles#index'
end
