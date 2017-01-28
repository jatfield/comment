require 'test_helper'

class FontSizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    global_setup
    @font_size = create(:font_size)
  end

  test "should get index" do
    get font_sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_font_size_url
    assert_response :success
  end

  test "should create font_size" do
    @font_size2 = build(:font_size)
    assert_difference('FontSize.count') do
      post font_sizes_url, params: { font_size: { name: @font_size2.name, value: @font_size2.value } }
    end

    assert_redirected_to font_size_url(FontSize.last)
  end

  test "should show font_size" do
    get font_size_url(@font_size)
    assert_response :success
  end

  test "should get edit" do
    get edit_font_size_url(@font_size)
    assert_response :success
  end

  test "should update font_size" do
    patch font_size_url(@font_size), params: { font_size: { name: @font_size.name, value: @font_size.value } }
    assert_redirected_to font_size_url(@font_size)
  end

  test "should destroy font_size" do
    assert_difference('FontSize.count', -1) do
      delete font_size_url(@font_size)
    end

    assert_redirected_to font_sizes_url
  end
end
