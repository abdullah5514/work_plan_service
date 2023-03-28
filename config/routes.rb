Rails.application.routes.draw do
  # resources :shifts
  # resources :workers
  resources :workers do
    resources :shifts, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
