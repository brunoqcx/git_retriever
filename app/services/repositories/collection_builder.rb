module Repositories
  class CollectionBuilder

    def initialize(repositories = [])
      @repositories = Array(repositories)
    end

    def call
      repositories.map do |repository|
        Repository.new(
          repository.slice(
            :full_name, 
            :description, 
            :forks_count, 
            :stargazers_count
          ).merge(owner: repository.dig(:owner, :login))
        )
      end
    end

    private

    attr_reader :repositories
  end
end
