Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users do
    resources :promotions, only: [:create, :destroy]
  end
  root 'home#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
