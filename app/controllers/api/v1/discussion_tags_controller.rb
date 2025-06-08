module Api
  module V1
    class DiscussionTagsController < ApplicationController
  before_action :set_discussion_tag, only: %i[ show update destroy ]

  # GET /discussion_tags
  def index
    @discussion_tags = DiscussionTag.all

    render json: @discussion_tags
  end

  # GET /discussion_tags/1
  def show
    render json: @discussion_tag
  end

  # POST /discussion_tags
  def create
    @discussion_tag = DiscussionTag.new(discussion_tag_params)

    if @discussion_tag.save
      render json: @discussion_tag, status: :created, location: @discussion_tag
    else
      render json: @discussion_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /discussion_tags/1
  def update
    if @discussion_tag.update(discussion_tag_params)
      render json: @discussion_tag
    else
      render json: @discussion_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /discussion_tags/1
  def destroy
    @discussion_tag.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion_tag
      @discussion_tag = DiscussionTag.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def discussion_tag_params
      params.expect(discussion_tag: [ :discussion_id, :tag_id ])
    end
    end
  end
end
