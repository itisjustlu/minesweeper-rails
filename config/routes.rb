Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: :create
      resources :boards do
        resources :cells, only: [] do
          member do
            put :mark
            put :red
            put :restore
            put :click
          end
        end
      end
    end
  end
end
