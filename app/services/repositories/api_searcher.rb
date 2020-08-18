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
          total: response_body[:total_count].to_i,
          items: items
        },
        status: status
      )
    end

    def response
      @response ||= Github::Repositories::Search::Request.new(params).call
    end

    def response_body
      @body ||= JSON.parse(response.body).deep_symbolize_keys
    end

    def status
      @status ||= response.status
    end

    def items
      CollectionBuilder.new(response_body[:items]).call
    end

    def error?
      status != 200
    end

    def errors
      { 
        errors: response_body[:errors],
        message: response_body[:message]
      }
    end
  end
end
