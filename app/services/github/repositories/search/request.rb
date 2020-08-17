module Github
  module Repositories
    module Search
      class Request
        PATH = '/search/repositories'

        def initialize(params = {})
          @params = params
        end

        def call
          api.get(path)
        end

        private

        attr_reader :params

        def path
          [PATH, query_string].compact.join('?')
        end

        def query_string
          QueryParser.new(params).call if params.present?
        end

        def api
          Connection.api(path)
        end
      end
    end
  end
end