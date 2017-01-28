require 'test_helper'

class PostsPerPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    global_setup
    @posts_per_page = create(:posts_per_page)
  end

  test "should get index" do
    get posts_per_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_posts_per_page_url
    assert_response :success
  end

  test "should create posts_per_page" do
    @posts_per_page2 = build(:posts_per_page)
    assert_difference('PostsPerPage.count') do
      post posts_per_pages_url, params: { posts_per_page: { value: @posts_per_page2.value } }
    end

    assert_redirected_to posts_per_page_url(PostsPerPage.last)
  end

  test "should show posts_per_page" do
    get posts_per_page_url(@posts_per_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_posts_per_page_url(@posts_per_page)
    assert_response :success
  end

  test "should update posts_per_page" do
    patch posts_per_page_url(@posts_per_page), params: { posts_per_page: { value: @posts_per_page.value } }
    assert_redirected_to posts_per_page_url(@posts_per_page)
  end

  test "should destroy posts_per_page" do
    assert_difference('PostsPerPage.count', -1) do
      delete posts_per_page_url(@posts_per_page)
    end

    assert_redirected_to posts_per_pages_url
  end
end
