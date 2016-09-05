require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  teardown do
    file_remove
  end

  test "correct_upload_should_save" do
    upload = build(:upload)
    assert upload.save, "Correct upload should be saved, but #{upload.errors.full_messages}"
  end

  test "upload_without_file_should_not_save" do
    upload = build(:upload, :file => nil)
    assert !upload.save, "Avatar without picture should not be saved"
  end

  test "upload_without_user_should_not_save" do
    upload = build(:upload, :user => nil)
    assert !upload.save, "Avatar without user should not be saved"
  end

  test "upload_without_post_should_not_save" do
    upload = build(:upload, :post => nil)
    assert !upload.save, "Avatar without user should not be saved"
  end
end
