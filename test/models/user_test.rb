require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "correct_user_should_save" do
    user = build(:user)
    assert user.save, "Correct user should be saved, but #{user.errors.full_messages}"
  end

  test "user_without_username_should_not_save" do
    user = build(:user, username: nil)
    assert !user.save, "User without username should not be saved"
  end

  test "user_with_same_username_should_not_save" do
    user1 = create(:user)
    user2 = build(:user, username: user1.username)
    assert !user2.save, "User with same username should not be saved"
  end

  test "user_without_email_should_not_save" do
    user = build(:user, email: nil)
    assert !user.save, "User without email should not be saved"
  end

  test "user_with_same_email_should_not_save" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email)
    assert !user2.save, "User with same email should not be saved"
  end

  test "should_return_active_users" do
    user1 = create(:user)
    user2 = create(:user, active: false)
    assert User.active.include?(user1) && !User.active.include?(user2), "#{User.active} does not include #{user1}, whose active field is #{user1.active}"
  end

end
