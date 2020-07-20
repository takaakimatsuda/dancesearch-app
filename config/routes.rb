Rails.application.routes.draw do

  get 'promotions/index'
  get 'promotions/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
  # ログインしていない時の初期画面
  root 'home#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
