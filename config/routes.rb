HmNews::Application.routes.draw do
  root :to => "news_items#index"
  resources :users, :only => [ :show, :edit, :update ] do
    resources :comments, :only => [ :index ]
    resources :news_items, :only => [ :index ]
  end
  resources :news_items, :only => [ :show, :index, :new, :create ] do
    resources :comments, :only => [ :index, :new, :create ]
    collection do
      get 'latest'
    end
    get 'upvote'
  end
  
  resources :comments, :only => [ :show, :new, :create] do
    #resources :comments, :as => :child, :only => [ :new => :new_child, :create => :create_child ]
    get 'new_child'
    post 'create_child'
    get 'upvote'
  end
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
