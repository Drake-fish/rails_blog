require 'test_helper'

class CreateTagsTest < ActionDispatch::IntegrationTest

  test "get new tag form and create tag" do
    get new_tag_path
    assert_template 'tags/new'
    assert_difference 'Tag.count', 1 do
      post tags_path, params: {tag: {name: "sports"}}
      follow_redirect!
    end
    assert_template 'tags/index'
    assert_match "sports", response.body
  end

  test "invalid tag submission results in failure" do
    get new_tag_path
    assert_template 'tags/new'
    assert_no_difference 'Tag.count' do
      post tags_path, params: {tag: {name: " "}}
    end
    assert_template 'tags/new'
    assert_select 'li.errors'
  end


end
