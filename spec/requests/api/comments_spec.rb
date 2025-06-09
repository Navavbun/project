require "swagger_helper"

RSpec.describe "api/comments", type: :request do
  path "/api/v1/comments/{id}" do
    get("show comments for discussion") do
      tags "Comments"
      produces "application/json"
      parameter name: :id, in: :path, type: :string, description: "Discussion ID"
      parameter name: :page, in: :query, type: :integer, description: "Page number"

      response(200, "successful") do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            text: { type: :string },
            discussion_id: { type: :integer }
            # ...add other comment fields if needed...
          }
        }
        let(:id) { Discussion.create!(topic: "Test", description: "Test desc").id }
        let(:page) { 1 }
        run_test!
      end
    end

    patch("update comment") do
      tags "Comments"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :string, description: "Comment ID"
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ["text"]
      }

      response(200, "successful") do
        let(:id) { Comment.create!(text: "Old", discussion: Discussion.create!(topic: "T", description: "D")).id }
        let(:comment) { { text: "Updated" } }
        run_test!
      end
    end

    put("update comment") do
      tags "Comments"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :string, description: "Comment ID"
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ["text"]
      }

      response(200, "successful") do
        let(:id) { Comment.create!(text: "Old", discussion: Discussion.create!(topic: "T", description: "D")).id }
        let(:comment) { { text: "Updated" } }
        run_test!
      end
    end

    delete("delete comment") do
      tags "Comments"
      parameter name: :id, in: :path, type: :string, description: "Comment ID"

      response(204, "no content") do
        let(:id) { Comment.create!(text: "To delete", discussion: Discussion.create!(topic: "T", description: "D")).id }
        run_test!
      end
    end
  end

  path "/api/v1/comments" do
    post("create comment") do
      tags "Comments"
      consumes "application/json"
      produces "application/json"
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          discussion_id: { type: :integer }
        },
        required: %w[text discussion_id]
      }

      response(201, "created") do
        let(:comment) { { text: "New comment", discussion_id: Discussion.create!(topic: "T", description: "D").id } }
        run_test!
      end

      response(422, "unprocessable entity") do
        let(:comment) { { text: "", discussion_id: nil } }
        run_test!
      end
    end
  end
end
