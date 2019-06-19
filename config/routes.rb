Rails.application.routes.draw do

  # =========================デバイスの機能を絞る設定==============================
  devise_for :admins, skip: :all

  devise_scope :admin do
    get 'login', to: 'devise/sessions#new', as: 'new_admin_session'
    post 'login', to: 'devise/sessions#create', as: 'admin_session'
    delete 'logout', to: 'devise/sessions#destroy', as: 'destroy_admin_session'
  end
  # ===========================================================================

  # トップページをitemsのindexに設定
  root 'items#index'

  # namespaceでadmin配下にitemsを配置
  namespace :admin do
    resources :items
    resources :purchased_histories, only: [:index, :show]
    put 'statuschange/:id', to: 'items#statuschange', as: 'statuschange'
    get 'confirm/:id', to: 'items#confirm', as: 'confirm'
    put 'shippingchange/:id', to: 'purchased_histories#shippingchange', as: 'shippingchange'
  end

  # 一般のページ
  resources :items, only: [:index, :show]
  resources :purchased_histories, only: [:new, :create]
  post 'purchased_histories/sessioncreate', to: 'purchased_histories#sessioncreate', as: 'sessioncreate'
  get 'purchased_histories/sessiondestroy/:id', to: 'purchased_histories#sessiondestroy', as: 'sessiondestroy'

  # refilegem用
  resources :post_images, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
