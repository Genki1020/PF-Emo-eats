Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: 'homes#top'
 get 'home/about'
resources :users
resources :emos
resources :eateries do
resource :favorites, only: [:create, :destroy]
resources :post_comments, only: [:create, :destroy]
end


end
