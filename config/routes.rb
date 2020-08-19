Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :repositories, only: [:index]
    end
  end

  get '/repositories', to: 'api/v1/repositories#index'
end
