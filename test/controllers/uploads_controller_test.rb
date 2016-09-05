require 'test_helper'

class UploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @upload = create(:upload)
    global_setup
  end

  test "should get index" do
    get uploads_url
    assert_response :success
  end


  test "should destroy upload" do
    assert_difference('Upload.count', -1) do
      delete upload_url(@upload)
    end

    assert_redirected_to root_url
  end
end
