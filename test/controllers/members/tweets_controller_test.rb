require 'test_helper'

class Members::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_tweets_index_url
    assert_response :success
  end

  test "should get show" do
    get members_tweets_show_url
    assert_response :success
  end

  test "should get edit" do
    get members_tweets_edit_url
    assert_response :success
  end

end
