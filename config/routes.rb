Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:new, :create, :index, :show, :destroy]
  end
  resources :users, only: [:show, :edit, :update ,:index]

end
