require 'test_helper'

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    global_setup
    @avatar = create(:avatar, user: @user)
  end

  teardown do
    file_remove
  end

  test "should not get anything if not logged in" do
    delete sign_out_url
    get new_avatar_url, params: { user_id: @user.id }
    assert_response :redirect
    get edit_avatar_url(@avatar)
    assert_response :redirect
    post avatars_url, params: { avatar: { user_id: @user.id, picture: fixture_file_upload('test/fixtures/test_avatar.png', 'application/image') } }
    assert_response :redirect
    patch avatar_url(@avatar), params: { avatar: { user_id: @avatar.user_id } }
    assert_response :redirect
    delete avatar_url(@avatar)
    assert_response :redirect
  end

  test "should get new" do
    get new_avatar_url, params: { user_id: @user.id }
    assert_response :success
  end

  test "should create avatar" do
    user2 = create(:user)
    assert_difference('Avatar.count') do
      post avatars_url, params: { avatar: { user_id: user2.id, picture: fixture_file_upload('test/fixtures/test_avatar.png', 'image/png') } }
    end

    assert_redirected_to user_url(Avatar.last.user)
  end

  test "should get edit" do
    get edit_avatar_url(@avatar)
    assert_response :success
  end

  test "should update avatar" do
    patch avatar_url(@avatar), params: { avatar: { user_id: @avatar.user_id } }
    assert_redirected_to user_url(@avatar.user)
  end

  test "should destroy avatar" do
    assert_difference('Avatar.count', -1) do
      delete avatar_url(@avatar)
    end

    assert_redirected_to user_url(@avatar.user)
  end
end
