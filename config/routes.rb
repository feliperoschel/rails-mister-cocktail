Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :new, :create] do
    # resources :doses, shallow: true
    resources :doses, only: [:new, :create, :destroy]
  end
  resources :doses, only: [:destroy]
  root to: 'cocktails#index'
end
