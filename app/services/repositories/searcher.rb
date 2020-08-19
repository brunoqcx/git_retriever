module Repositories
  class Searcher

    def initialize(params = {})
      @params = params.to_h.symbolize_keys
    end

    def call
      OpenStruct.new(
        status: status,
        body: body
      )
    end

    private

    attr_reader :params

    def response
      @response ||= Github::Repositories::Search::Request.new(params).call
    end

    def response_body
      @body ||= JSON.parse(response.body).deep_symbolize_keys
    end

    def status
      response.status
    end

    def body
      {
        total: response_body[:total_count].to_i,
        data: data,
        errors: response_body[:errors]
      }.compact
    end

    def data
      CollectionBuilder.new(response_body[:items]).call
    end
  end
end
