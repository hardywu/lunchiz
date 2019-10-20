Rails.application.routes.draw do
  resources :reviews do
    member do
      patch 'reply'
    end
  end
  resources :stores
  resources :users
  post 'auth/signin'
  post 'auth/signup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
