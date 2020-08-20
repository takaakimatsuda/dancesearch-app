Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows
      get :followers
    end
    resources :promotions, only: [:create, :destroy]
    resources :scores, only: [:create, :destroy]
    resources :lessons, only: [:create, :destroy, :update]
  end
  resources :home, only: [:index]
  resources :announcements, only: [:index, :show, :create, :destroy]
  root 'users#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
