Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :patients do
    resources :consultations, only: %i[create index edit update destroy]
  end
  resources :advance_searches, only: %i[new index]

  root 'patients#index'
end
