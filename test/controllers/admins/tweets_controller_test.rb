require 'test_helper'

class Admins::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_tweets_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_tweets_show_url
    assert_response :success
  end

end
