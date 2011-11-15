Blogotron::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  resources :users, :only => [:index] do
    resources :posts, :only => [:index]
  end
  
  resources :posts do
    resources :comments, :only => [:create]
  end
  resources :comments, :only => [:update, :destroy]
  
  match 'blogs/:user_id' => 'posts#index', :as => :blogs
  
  root :to => 'posts#index'
end
