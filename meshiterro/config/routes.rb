Rails.application.routes.draw do
  root 'post_images#index'
  devise_for :users
  resources :post_images, only: [:new, :create, :index, :show]
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
  resources :users, only: [:show, :edit, :update]
end
