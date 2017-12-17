require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get comments_index_url
    assert_response :success
  end

  test "should get edit" do
    get comments_edit_url
    assert_response :success
  end

end
