require 'test_helper'

class ListTagsTest < ActionDispatch::IntegrationTest

  def setup
    @tag = Tag.create(name: "sports")
    @tag2 = Tag.create(name: "computers")
  end

  test "should show the tag listing" do
    get tags_path
    assert_template 'tags/index'
    assert_select "a[href=?]", tag_path(@tag), text: @tag.name
    assert_select "a[href=?]", tag_path(@tag2), text: @tag2.name
  end
end
