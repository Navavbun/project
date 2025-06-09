module Api
  module V1
    class CommentsController < ApiController
      before_action :set_comment, only: %i[update destroy]

      # GET /comments/1
      def show
        @comments = Comment.where(discussion_id: params.expect(:id))

        page = params[:page] || 1
        render json: @comments.page(page).per(@@per)
      end

      # POST /comments
      def create
        @comment = Comment.new(params.expect(comment: %i[text discussion_id]))

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      def update
        if @comment.update(params.expect(comment: [:text]))
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /comments/1
      def destroy
        @comment.destroy!
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params.expect(:id))
      end
    end
  end
end
