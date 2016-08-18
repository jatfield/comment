require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, name: "Titok János", password: "titok123", password_confirmation: "titok123")
  end

  test "should get login page" do
    delete sign_out_url
    get sign_in_url
    assert_response :success
  end

  test "should be able to login" do
    delete sign_out_url
    post user_sessions_url, params: { user_session: {username: @user.username, password: "titok123"}}
    assert_redirected_to root_url 
  end

  test "inactive should not be able to login" do
    delete sign_out_url
    inactive_user = create(:user, name: "Titok János", password: "titok123", password_confirmation: "titok123", active: false)
    post user_sessions_url, params: { user_session: {username: inactive_user.username, password: "titok123"}}
    assert_response :success
  end

  test "should be able to logout" do
    delete sign_out_url
    delete sign_out_url
    assert_redirected_to sign_in_url 
  end

end
