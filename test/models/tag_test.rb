require 'test_helper'

class TagTest < ActiveSupport::TestCase

  def setup
    @tag = Tag.new(name: "sports")
  end

  test "tag should be valid" do
    assert @tag.valid?
  end

  test "name should be present" do
    @tag.name = " "
    assert_not @tag.valid?
  end

  test "name should be unique" do
    @tag.save
    tag2 = Tag.new(name: "sports")
    assert_not tag2.valid?
  end

  test "name should not be to long" do
    @tag.name = "lkasdjfkajsdlkfjlksadfjlksadjfkljasdklfjkljsdkfjskdlfjklsdfjlkdsjflksdjfsdjkfkjsdfklkasdfjlkasjfajskfdjlasdfksadf"
    assert_not @tag.valid?
  end

  test "name should not be to short" do
    @tag.name ="1"
    assert_not @tag.valid?
  end
end
