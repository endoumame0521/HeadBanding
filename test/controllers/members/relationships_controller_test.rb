require 'test_helper'

class Members::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follower" do
    get members_relationships_follower_url
    assert_response :success
  end

  test "should get followed" do
    get members_relationships_followed_url
    assert_response :success
  end

end
