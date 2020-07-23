Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
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
  end
  root 'home#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
