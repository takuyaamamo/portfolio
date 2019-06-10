Rails.application.routes.draw do
  devise_for :admins

  # トップページをitemsのindexに設定
  root 'items#index'

  # namespaceでadmin配下にitemsを配置
  namespace :admin do
    resources :items
    resources :purchased_histories
    put 'statuschange/:id', to: 'items#statuschange', as: 'statuschange'
    get 'confirm/:id', to: 'items#confirm', as: 'confirm'
  end
  # 一般のページ
  resources :items
  resources :purchased_histories

  # refilegem用
  resources :post_images, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
