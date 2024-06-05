Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :patients do
    resources :consultations, only: %i[create index edit update]
  end

  root 'patients#index'
end
