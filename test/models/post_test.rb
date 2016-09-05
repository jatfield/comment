require 'test_helper'

class PostTest < ActiveSupport::TestCase
 
  test "correct_post_should_save" do
    post = FactoryGirl.build(:post)
    assert post.save, "Correct post should be saved, but #{post.errors.full_messages}"
  end

  test "post_without_topic_should_not_save" do
    post = FactoryGirl.build(:post, topic: nil)
    assert !post.save, "Post without topic should not be saved"
  end

  test "post_without_user_should_not_save" do
    post = FactoryGirl.build(:post, user: nil)
    assert !post.save, "Post without user should not be saved"
  end

  test "post_without_text_should_not_save" do
    post = FactoryGirl.build(:post, full_text: nil)
    assert !post.save, "Post without text should not be saved"
  end

  test "post_without_number_should_not_save" do
    post = FactoryGirl.build(:post, number: nil)
    assert !post.save, "Post without number should not be saved"
  end

  test "post_with_same_number_should_not_save" do
    post0 = FactoryGirl.create(:post, number: 1)
    post = FactoryGirl.build(:post, number: post0.number, topic: post0.topic)
    assert !post.save, "Post with same number should not be saved"
  end

  test "should_return_question_chain" do
    question = create(:post)
    answer1 = create(:post, answer_to: question)
    answer2 = create(:post, answer_to: answer1)
    assert answer2.question_chain == [answer1, question], "Instead: #{[answer1, question]} it is #{answer2.question_chain}"

  end

  test "should_return_search_results" do
    post1 = create(:post, full_text: "Blabliblu")
    post2 = create(:post, full_text: "Blebloblö")
    post3 = create(:post, full_text: "Bliblubla")
    term = "bli"
    assert Post.search(term).include?(post1) && !Post.search(term).include?(post2), "Keresés: Blabli, eredmény: #{Post.search("Blabli")}"
  end

end
