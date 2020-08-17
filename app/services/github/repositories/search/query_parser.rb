module Github
  module Repositories
    module Search
      class QueryParser

        DEFAULT_LANGUAGE = 'ruby'

        def initialize(q:, language: 'ruby', per_page: 1, page: 1, sort: 'stars', order: 'desc')
          @q = q
          @language = language
          @per_page = per_page
          @page = page
          @sort = sort
          @order = order
        end

        def call
          search
        end

        private

        def search
          "q=#{q}+language:#{language}$sort=#{sort}&order=#{order}&page=#{page}&per_page=#{per_page}"
        end

        attr_reader :q, :language, :per_page, :page, :sort, :order
      end
    end
  end
end