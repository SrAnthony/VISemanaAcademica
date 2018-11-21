Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  root 'index#index'
  # root 'index#under_construction'

  get 'admin' => 'index#index'
  get 'dash' => 'index#dash', as: :dash
  get 'account' => 'users#account', as: :user_account
  get 'category' => 'users#category', as: :user_category

  post 'generate_payment' => 'users#generate_payment', as: :user_generate_payment
  post 'update_transaction_code' => 'users#update_transaction_code', as: :user_update_transaction_code
  patch 'update_category/:category' => 'users#update_category', as: :user_update_category
end
