Rails.application.routes.draw do

  get 'search/search'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: 'eateries#index'
 get 'home/about'
resources :users
resources :emos
resources :eateries do
resource :favorites, only: [:create, :destroy]
resources :post_comments, only: [:create, :destroy]
end
resources :contacts, only: [:new, :create]
post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
post 'contacts/back', to: 'contacts#back', as: 'back'
get 'done', to: 'contacts#done', as: 'done'
resources :notifications, only: :index
end
