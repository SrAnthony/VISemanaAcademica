Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  root 'index#index'

  get 'account' => 'users#account', as: :user_account
  get 'category' => 'users#category', as: :user_category
  patch 'update_category/:category' => 'users#update_category', as: :user_update_category
end
