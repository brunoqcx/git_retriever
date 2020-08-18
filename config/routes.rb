Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :repositories, only: [] do
        collection do
          get :search
        end
      end
    end
  end

  get '/search', to: 'api/v1/repositories#search'
end
