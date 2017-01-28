require 'test_helper'

class FontSizeTest < ActiveSupport::TestCase
  test "correct_font_size_should_save" do
    font_size = FactoryGirl.build(:font_size)
    assert font_size.save, "Correct font_size should be saved, but #{font_size.errors.full_messages}"
  end

  test "font_size_with_same_number_should_not_save" do
    font_size0 = FactoryGirl.create(:font_size, value: 1)
    font_size = FactoryGirl.build(:font_size, value: font_size0.value)
    assert !font_size.save, "Font size with same value should not be saved"
  end

  test "font_size_with_same_name_should_not_save" do
    font_size0 = FactoryGirl.create(:font_size, name: "1")
    font_size = FactoryGirl.build(:font_size, name: font_size0.name)
    assert !font_size.save, "Font size with same name should not be saved"
  end
end
