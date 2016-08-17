require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    global_setup
  end

  test "should not get anything if not logged in" do
    delete sign_out_url
    get users_url
    assert_response :redirect
  end

  test "should get forgotten_password" do
    delete sign_out_url
    get forgotten_password_users_url
    assert_response :success
  end

  test "should send forgotten_password_link" do
    delete sign_out_url
    post send_password_reset_link_users_url, params: {username: @user.username}
    assert_redirected_to sign_in_url
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    @user2 = build(:user)
    assert_difference('User.count') do
      post users_url, params: { user: { active: true, email: @user2.email, username: @user2.username, password: "Másmilyen", password_confirmation: "Másmilyen", signature: "Aláírom" }}
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { active: @user.active, email: @user.email, username: @user.username, password: "Másmilyen", password_confirmation: "Másmilyen", signature: "Aláírom" } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.active.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
