require 'test_helper'

class CreateTagsTest < ActionDispatch::IntegrationTest

  def setup
    @tag = Tag.create(name: "sports")
    @user = User.create(username: "bob1", email: "John@example.com", password: "password", admin:true)
  end

  test "get new tag form and create tag" do
    sign_in_as(@user, "password")
    get new_tag_path
    assert_template 'tags/new'
    assert_difference 'Tag.count', 1 do
      post tags_path, params: {tag: {name: "travel"}}
      follow_redirect!
    end
    assert_template 'tags/index'
    assert_match "travel", response.body
  end

  test "invalid tag submission results in failure" do
    sign_in_as(@user, "password")
    get new_tag_path
    assert_template 'tags/new'
    assert_no_difference 'Tag.count' do
      post tags_path, params: {tag: {name: " "}}
    end
    assert_template 'tags/new'
    assert_select 'li.errors'
  end


end
