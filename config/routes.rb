Rails.application.routes.draw do
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get 'searches/search'
    devise_for :users
    get "users" => redirect("/users/sign_up")
   
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :create, :show, :edit, :update, :destroy ] do
      member do 
        get :follows, :followers
        get :favorites
      end
        resource :relationships, only: [:create, :destroy]
    end
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end
    resource :map, only: [:show]
  end

  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do 
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
end
