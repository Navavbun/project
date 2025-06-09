require "test_helper"

class DiscussionTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discussion_tag = discussion_tags(:one)
  end

  test "should get index" do
    get discussion_tags_url, as: :json
    assert_response :success
  end

  test "should create discussion_tag" do
    assert_difference("DiscussionTag.count") do
      post discussion_tags_url,
           params: { discussion_tag: {
             discussion_id: @discussion_tag.discussion_id,
             tag_id: @discussion_tag.tag_id
           } }, as: :json
    end

    assert_response :created
  end

  test "should show discussion_tag" do
    get discussion_tag_url(@discussion_tag), as: :json
    assert_response :success
  end

  test "should update discussion_tag" do
    patch discussion_tag_url(@discussion_tag),
          params: { discussion_tag: {
            discussion_id: @discussion_tag.discussion_id,
            tag_id: @discussion_tag.tag_id
          } }, as: :json
    assert_response :success
  end

  test "should destroy discussion_tag" do
    assert_difference("DiscussionTag.count", -1) do
      delete discussion_tag_url(@discussion_tag), as: :json
    end

    assert_response :no_content
  end
end
