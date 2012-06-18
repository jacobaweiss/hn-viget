Hn::Application.routes.draw do
  resources :articles
  resources :users, :except => [:destroy, :edit]
  resources :sessions, :only => [:new, :create, :destroy]
  resource :emails

  root :to => 'articles#index'
  match '/login',           :to => 'sessions#new'
  match '/logout',          :to => 'sessions#destroy', via: :delete
  match '/signup',          :to => 'users#new'
  match '/change_password', :to => 'users#password'
  match '/reset_password',  :to => 'emails#new'
end
