Rails.application.routes.draw do
  devise_for :users
  # ログインしていない時の初期画面
  root 'home#index'
end
