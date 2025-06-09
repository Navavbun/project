require "swagger_helper"

RSpec.describe "api/discussions", type: :request do
  path "/api/v1/discussions" do
    get("list discussions") do
      tags "Discussions"
      produces "application/json"
      parameter name: :text, in: :query, type: :string, description: "Search text"
      parameter name: :page, in: :query, type: :integer, description: "Page number"

      response(200, "successful") do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            topic: { type: :string },
            description: { type: :string }
          }
        }
        let(:text) { nil }
        let(:page) { 1 }
        run_test!
      end
    end
  end

  path "/api/v1/discussions/{id}" do
    get("show discussion") do
      tags "Discussions"
      produces "application/json"
      parameter name: :id, in: :path, type: :string, description: "Discussion ID"
      parameter name: :page, in: :query, type: :integer, description: "Comments page"

      response(200, "successful") do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 topic: { type: :string },
                 description: { type: :string },
                 comments: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       text: { type: :string },
                       discussion_id: { type: :integer }
                     }
                   }
                 }

               }
        let(:id) { Discussion.create!(topic: "Test", description: "Test desc").id }
        let(:page) { 1 }
        run_test!
      end

      response(404, "not found") do
        let(:id) { "invalid" }
        let(:page) { 1 }
        run_test!
      end
    end
  end
end
