module Api::V1
  class RepositoriesController < ApplicationController

    def index
      render json: repositories_response.body, status: repositories_response.status
    end

    private

    def repositories_response
      @repositories_response ||= Repositories::Searcher.new(search_params).call
    end

    def search_params
      search_defaulted_params.merge(search_permited_params)
    end

    def search_permited_params
      params.permit(:q, :sort, :order, :user)
    end

    def search_defaulted_params
      {
        language: params['language'] || 'ruby',
        page: params['page'] || 1,
        per_page: params['per_page'] || 10
      }
    end
  end
end
