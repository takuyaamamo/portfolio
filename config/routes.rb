Rails.application.routes.draw do

  devise_for :admins
  # トップページをitemsのindexに設定
  root 'items#index'

  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
