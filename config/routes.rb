HmNews::Application.routes.draw do
  root :to => "newsitems#index"
  resources :users, :only => [ :show, :edit, :update ] do
    resources :comments, :only => [ :index ]
  end
  resources :newsitems, :only => [ :show, :index, :new, :create ] do
    resources :comments, :only => [ :index, :new, :create ]
    collection do
      get 'latest'
    end
  end
  
  resources :comments, :only => [ :show, :new, :create]
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
