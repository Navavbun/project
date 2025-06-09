module Api
  module V1
    class DiscussionsController < ApplicationController
      # GET /discussions
      def index
        text = params[:text].to_s
        @discussions = []

        if text.present?
          @discussions = Discussion.all
            .where(Discussion.arel_table[:topic].matches("%#{text}%"))
            .or(
              Discussion.where(Discussion.arel_table[:description].matches("%#{text}%"))
            )
        else
          @discussions = Discussion.all
        end

        page = params[:page] || 1
        render json: @discussions.page(page).per(@@per)
      end

      # GET /discussions/1
      def show
        @discussion = Discussion.find(params.expect(:id))

        render json: @discussion, serializer: DetailedDiscussionSerializer,
               comments_page: params[:page] || 1,
               comments_per: @@per
      end
    end
  end
end
