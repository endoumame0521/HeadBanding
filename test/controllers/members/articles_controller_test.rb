require 'test_helper'

class Members::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_articles_index_url
    assert_response :success
  end

  test "should get new" do
    get members_articles_new_url
    assert_response :success
  end

  test "should get show" do
    get members_articles_show_url
    assert_response :success
  end

  test "should get edit" do
    get members_articles_edit_url
    assert_response :success
  end

end
