Rails.application.routes.draw do
  resources :reviews do
    member do
      patch 'reply'
    end
  end
  resources :stores
  resources :users, except: :create do
    member do
      patch 'adminize'
    end
  end
  post 'auth/signin'
  post 'auth/signup'
  get 'auth/me'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
