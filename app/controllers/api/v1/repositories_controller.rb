module Api::V1
  class RepositoriesController < ApplicationController

    def index
      render json: repositories_response.body, status: repositories_response.status
    end

    private

    def repositories_response
      @repositories_response ||= Repositories::ApiSearcher.new(search_params).call
    end

    def search_params
      defaulted_params.merge(permited_params)
    end

    def permited_params
      params.permit(:sort, :order, :user)
    end

    def defaulted_params
      {
        q: params['q'] || nil,
        language: params['language'] || 'ruby',
        page: params['page'] || 1,
        per_page: params['per_page'] || 10
      }
    end
  end
end
