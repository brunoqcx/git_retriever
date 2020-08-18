module Api::V1
  class RepositoriesController < ApplicationController

    def search
      render json: collection, status: :ok
    end

    private

    def collection
      @collection ||= Repositories::ApiSearcher.new(search_params).call
    end

    def search_params
      permited_params.merge!(defaulted_params)
    end

    def permited_params
      params.permit(:page, :per_page, :sort, :order)
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