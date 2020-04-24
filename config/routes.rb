Rails.application.routes.draw do
  resources :group_friends
  resources :groups
  resources :order_friends
  resources :orders
  resources :friendships
  post 'friendships/add_friend_by_name', to: 'friendships#add_friend_by_name'
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
end
