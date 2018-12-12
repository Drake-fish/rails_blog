require 'test_helper'

class TagControllerTest < ActionDispatch::IntegrationTest

  def setup
    @tag = Tag.create(name: "sports")
    @user = User.create(username: "bob1", email: "John@example.com", password: "password", admin:true)
  end
  test "should get categories index" do
    get tags_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "password")
    get new_tag_path
    assert_response :success
  end

  test "should get show" do
    get tag_path(@tag)
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Tag.count' do
      post tags_path, params: {tag: {name: "sports"}}
    end
    assert_redirected_to tags_path
  end
end
