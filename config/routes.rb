Rails.application.routes.draw do

  devise_for :admins
  # トップページをitemsのindexに設定
  root 'items#index'

  resources :items

  resources :post_images, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
