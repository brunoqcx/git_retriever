require 'faraday'

module Github
  class Connection
    BASE = 'https://api.github.com'

    def self.api(path = '')
      url = "#{BASE}#{path}"

      Faraday.new(url: url) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
      end
    end
  end
end