Rails.application.routes.draw do
  root to: "sessions#new"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :dashboard, only: [:index]
  resources :expenses, only: [:index]
  resources :insights, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :expenses, only: [:index, :create, :destroy, :update]
      resources :categories, only: [:index, :create, :update, :destroy]
      resources :reports do
        get :year, on: :collection
        get :month, on: :collection
      end
      resources :goals, only: [:index] do
        put :update, on: :collection
      end
    end
  end

  get "/404", to: "errors#not_found"
  get "/422", to: "errors#not_found"
  get "/500", to: "errors#not_found"
end
