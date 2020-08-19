module Github
  module Repositories
    module Search
      class QueryParser

        SEARCH_TERMS = [:language, :user]
        OTHER_TERMS = [:sort, :order, :page, :per_page] 

        def initialize(params)
          @params = params
          @q = @params[:q].to_s
        end

        def call
          query_string
        end

        private

        def query_string
          "q=#{q}".tap do |query_string| #without this default a /search github query breaks
            query_string.concat(generate_search_terms)
            query_string.concat(generate_other_terms)
          end
        end

        def generate_search_terms
          params.slice(*SEARCH_TERMS).inject('') do |c, (k, v)|
            c.concat("+#{k}:#{v}")
          end
        end

        def generate_other_terms
          params.slice(*OTHER_TERMS).inject('') do |c, (k, v)|
            c.concat("&#{k}=#{v}")
          end
        end

        attr_reader :q, :params
      end
    end
  end
end