module Repositories
  class ApiSearcher

    def initialize(params = {})
      @params = params.to_h.symbolize_keys
    end

    def call
      result.tap do |result|
        result.body.merge!(errors) if error?
      end
    end

    private

    attr_reader :params

    def result
      OpenStruct.new(
        body: {
          total: response_body.dig('total_count').to_i,
          data: items
        },
        status: status
      )
    end

    def response
      @response ||= Github::Repositories::Search::Request.new(params).call
    end

    def response_body
      @body ||= JSON.parse(response.body)
    end

    def status
      @status ||= response.status
    end

    def items
      items = response_body.dig('items') || []

      items.map { |item| item.slice('full_name', 'description', 'forks_count', 'stargazers_count') }
    end

    def error?
      status != 200
    end

    def errors
      { 
        errors: response_body['errors'],
        message: response_body['message']
      }
    end
  end
end
