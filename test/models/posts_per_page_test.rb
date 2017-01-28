require 'test_helper'

class PostsPerPageTest < ActiveSupport::TestCase
  test "correct_posts_per_page_should_save" do
    posts_pp = FactoryGirl.build(:posts_per_page)
    assert posts_pp.save, "Correct posts_per_page should be saved, but #{posts_pp.errors.full_messages}"
  end

  test "posts_per_page_with_same_value_should_not_save" do
    posts_pp0 = FactoryGirl.create(:posts_per_page, value: 1)
    posts_pp = FactoryGirl.build(:posts_per_page, value: posts_pp0.value)
    assert !posts_pp.save, "Posts_per_page with same value should not be saved"
  end

end
