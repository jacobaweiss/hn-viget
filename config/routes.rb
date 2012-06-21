Hn::Application.routes.draw do
  resources :articles do
    resources :comments
  end
  
  resources :comments do
    resources :comments
  end
  
  
  resources :users, :except => [:destroy, :edit]
  resources :sessions, :only => [:new, :create, :destroy]
  resource :password_resets

  root :to => 'articles#index'
  match '/articles',        :to => 'articles#index'
  match '/login',           :to => 'sessions#new'
  match '/logout',          :to => 'sessions#destroy', via: :delete
  match '/signup',          :to => 'users#new'
  match '/change_password', :to => 'users#password'
  match '/reset_password',  :to => 'password_resets#new'
end
