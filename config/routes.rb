Rails.application.routes.draw do

  namespace :api do
    resources :sports, only: [:index, :create, :update, :destroy] do
      resources :events, only: [:index, :create, :update, :destroy]
    end
  end

end
