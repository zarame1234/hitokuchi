Rails.application.routes.draw do
   root to: "homes#top"
  devise_for :users
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do 
    get 'dashboards', to: 'dashborads#index'
    resources :users, only: [:destroy]
  end
  
  get '/about' => 'homes#about'
  get 'searches/search'

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :create, :show, :edit, :update, :destroy ]

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end
