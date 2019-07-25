Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :new, :create] do
    resources :doses, shallow: true
  end
  # resources :doses, only: [:destroy]
  # resources :doses, only: [:new, :create, :destroy]
  root to: 'cocktails#index'
end
