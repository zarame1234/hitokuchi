Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users
  root to: "homes#top"
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
