require 'test_helper'

class AvatarTest < ActiveSupport::TestCase

  teardown do
    file_remove
  end

  test "correct_user_avatar_should_save" do
    avatar = FactoryGirl.build(:avatar)
    assert avatar.save, "Correct avatar should be saved, but #{avatar.errors.full_messages}"
  end

  test "user_avatar_without_picture_should_not_save" do
    avatar = FactoryGirl.build(:avatar, :picture => nil)
    assert !avatar.save, "Avatar without picture should not be saved"
  end

  test "user_avatar_without_user_should_not_save" do
    avatar = FactoryGirl.build(:avatar, :user => nil)
    assert !avatar.save, "Avatar without user should not be saved"
  end

end
