Rails.application.routes.draw do
  get 'model3ds/me', to: 'model3ds#me'
  resources :model3ds
  resources :model3ds do
    member do
      get 'download'
    end
  end
  root 'static#landing'

  get '/3dview', to: 'static#view3d'


  resources :projects
  resources :projects do
    member do
      patch :accept
    end
  end
  # resources :posts
  resources :topics do
    resources :posts
  end

  resources :posts

  resources :comments

  devise_for :users
  resources :users do
    resources :reviews, only: [:new, :create]
  end
  # get '/users/:user_id/reviews/new', to: 'reviews#new_review_for_user', as: 'new_review_for_user'
  # get '/users/:user_id/reviews/new', to: 'reviews#new', as: 'new_user_review'
  # post '/users/:user_id/reviews', to: 'reviews#create'
 
  resources :home
  resources :subscriptions, except: [:destroy]
  get '/subscriptions/new' => 'subscriptions#create'  
  delete '/subscriptions/:id/delete' => 'subscriptions#destroy', as: 'subscriptions_delete'
  get '/subscriptions/:id/delete' => 'subscriptions#destroy'
  # resources :project_profiles
  resources :post_profiles

  resources :project_profiles do
    resources :reviews, only: [:new, :create]
  end
  
  resources :flags, only: [:create]


end
