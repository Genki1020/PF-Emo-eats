Rails.application.routes.draw do
 root to: 'eateries#index'
 get 'search/search'
 get 'about' => 'homes#about'
 get 'done', to: 'contacts#done', as: 'done'
 post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
 post 'contacts/back', to: 'contacts#back', as: 'back'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

devise_for :users
resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
end

resources :emos
resources :eateries do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
end

resources :contacts, only: [:new, :create]
resources :notifications, only: :index
end