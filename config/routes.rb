Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows
      get :followers
    end
    resources :promotions, only: [:create, :destroy]
    resources :scores, only: [:create]
    resource :profile, only: [] do
      delete :destroy_image
    end
  end
  resources :home, only: [:index]
  resources :announcements, only: [:index, :show, :create, :destroy]
  resources :notifications, only: :index
  root 'home#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
