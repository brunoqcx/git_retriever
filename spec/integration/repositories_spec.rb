require 'swagger_helper'

RSpec.describe '/api/v1/repositories', type: :request do

  path '/api/v1/repositories' do
    get 'Retrieves repositories' do
      tags 'Repositories'
      produces 'application/json'
      parameter name: :q, in: :query, type: :string, required: false, description: 'Textual search'
      parameter name: :language, in: :query, type: :string, required: false, description: 'Programming language search'
      parameter name: :user, in: :query, type: :string, required: false, description: 'User login search'
      parameter name: :sort, in: :query, type: :string, required: false, description: 'Sort option (stars, forks and update are the challenge options)'
      parameter name: :order, in: :query, type: :string, required: false, description: 'Order criteria, use desc or asc (desc is default)'
      parameter name: :page, in: :query, type: :string, required: false, description: 'Page for exhibition'
      parameter name: :per_page, in: :query, type: :string, required: false, description: 'Number of items in page'

      response '200', 'repositories found' do
        schema(
          type: :object,
          properties: {
            total: { type: 'integer' },
            data: {
              type: :array,
              items: {
                properties: {
                  full_name: { type: :string, },
                  description: { type: :string },
                  forks_count: { type: :integer },
                  stargazers_countus: { type: :integer },
                  owner: { type: :string }
                }
              }
            }
          }
        )

        run_test!
      end
    end
  end
end