require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topic = create(:topic)
    global_setup
  end

  test "should get index" do
    get topics_url
    assert_response :success
  end

  test "should get new" do
    get new_topic_url
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      post topics_url, params: { topic: { name: @topic.name, user_id: @topic.user_id } }
    end

    assert_redirected_to topic_url(Topic.last)
  end

  test "should show topic" do
    get topic_url(@topic)
    assert_response :success
  end

  test "should get edit" do
    get edit_topic_url(@topic)
    assert_response :success
  end

  test "should update topic" do
    patch topic_url(@topic), params: { topic: { name: @topic.name, user_id: @topic.user_id } }
    assert_redirected_to topic_url(@topic)
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete topic_url(@topic)
    end

    assert_redirected_to topics_url
  end

  test "should not get anything if not logged in" do
    delete sign_out_url
    get topics_url
    assert_response :redirect
    get new_topic_url
    assert_response :redirect
    post topics_url, params: { topic: { name: @topic.name, user_id: @topic.user_id } }
    assert_response :redirect
    get topic_url(@topic)
    assert_response :redirect
    get edit_topic_url(@topic)
    assert_response :redirect
    patch topic_url(@topic), params: { topic: { name: @topic.name, user_id: @topic.user_id } }
    assert_response :redirect
    delete topic_url(@topic)
    assert_response :redirect
  end
end
