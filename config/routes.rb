Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'dashboard#show'

  resources :dashboard, only: :show
  resources :categories
  resources :companies
  resources :exchange_rates, except: :show
  resources :box_types

  resources :brands do
    collection do
      get 'download'
    end
  end

  resources :items do
    collection do
      get 'upload'
      post 'import'
      get 'download'
    end
  end

end
