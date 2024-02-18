Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :patients do
    resources :consultations, only: %i[create index]
  end

  root 'patients#index'
end
