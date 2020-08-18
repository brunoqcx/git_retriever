module Github
  module Repositories
    module Search
      class QueryParser

        def initialize(q: nil, language: nil, per_page: nil, page: nil, sort: nil, order: nil)
          @q = q
          @language = language
          @per_page = per_page
          @page = page
          @sort = sort
          @order = order
        end

        def call
          query_string
        end

        private

        def query_string
          "q=#{q}".tap do |query_string|
            query_string.concat("+language:#{language}") if language
            query_string.concat("#{query_string}&order=#{order}") if order
            query_string.concat("#{query_string}&page=#{page}") if page
            query_string.concat("#{query_string}&per_page=#{per_page}") if per_page
          end
        end

        attr_reader :q, :language, :per_page, :page, :sort, :order
      end
    end
  end
end