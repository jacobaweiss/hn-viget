Hn::Application.routes.draw do
  resources :articles
  resources :users, :only => [:new, :create, :show]
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => 'articles#index'
  match '/login',  :to => 'sessions#new'
  match '/logout', :to => 'sessions#destroy', via: :delete
  match '/signup', :to => 'users#new'
end
