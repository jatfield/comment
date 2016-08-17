require 'test_helper'

class TopicTest < ActiveSupport::TestCase
 
  test "correct_topic_should_save" do
    topic = build(:topic)
    assert topic.save, "Correct topic should be saved, but #{topic.errors.full_messages}"
  end

  test "topic_without_user_should_not_save" do
    topic = build(:topic, user: nil)
    assert !topic.save, "Topic without user should not be saved"
  end

  test "topic_without_name_should_not_save" do
    topic = build(:topic, name: nil)
    assert !topic.save, "Topic without text should not be saved"
  end

  test "should_return_last_post" do
    topic = create(:topic)
    post1 = create(:post, topic: topic, number: 1)
    post2 = create(:post, topic: topic, number: 2)
    post3 = create(:post, topic: topic, number: 3)
    assert topic.last_post == post3, "#{post3} was last, but returned #{topic.last_post}"
  end
end
