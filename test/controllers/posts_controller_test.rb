require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = create(:post)
    global_setup
  end

  teardown do
    file_remove
  end

  test "should not get anything if not logged in" do
    delete sign_out_url
    get posts_url
    assert_response :redirect
    post posts_url, params: { user_id: @post.user_id, topic_id: @post.topic_id, answer_to: @post.answer_to_id, full_text: @post.full_text }
    assert_response :redirect
    get edit_post_url(@post)
    assert_response :redirect
    patch post_url(@post), params: { post: { answer_to_id: @post.answer_to_id, full_text: @post.full_text, number: @post.number, topic_id: @post.topic_id, user_id: @post.user_id } }
    assert_response :redirect
    delete post_url(@post)
    assert_response :redirect
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should create post" do
    post2 = build(:post)
    assert_difference('Post.count') do
      post posts_url, params: { user_id: @post.user_id, topic_id: @post.topic_id, answer_to: post2.answer_to_id, full_text: post2.full_text }
    end

    assert_redirected_to topic_url(@post.topic)
  end

  test "should create post with upload" do
    post2 = build(:post)
    assert_difference('Upload.count') do
      post posts_url, params: { user_id: @post.user_id, topic_id: @post.topic_id, full_text: post2.full_text, images: [fixture_file_upload('test/fixtures/test_image.jpg', 'image/jpg')]}
    end
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { answer_to_id: @post.answer_to_id, full_text: @post.full_text, number: @post.number, topic_id: @post.topic_id, user_id: @post.user_id } }
    assert_redirected_to topic_url(@post.topic)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
