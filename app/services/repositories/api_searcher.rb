module Repositories
  class ApiSearcher

    def initialize(params = {})
      @params = params.to_h.symbolize_keys
    end

    def call
      result.tap do |result|
        result.merge!(errors) if error?
      end
    end

    private

    attr_reader :params

    def result
      {
        total: body.dig('total_count'),
        items: items
      }
    end

    def response
      @response ||= Github::Repositories::Search::Request.new(params).call
    end

    def body
      @body ||= JSON.parse(response.body)
    end

    def status
      @status ||= response.status
    end

    def items
      items = body.dig('items') || []

      items.map { |item| item.slice('full_name', 'description', 'forks_count', 'stargazers_count') }
    end

    def error?
      status != 200
    end

    def errors
      { errors: { status: response["status"], message: response["message"] } }
    end
  end
end