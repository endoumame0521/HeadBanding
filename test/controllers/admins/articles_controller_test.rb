require 'test_helper'

class Admins::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_articles_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_articles_show_url
    assert_response :success
  end

  test "should get update" do
    get admins_articles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_articles_destroy_url
    assert_response :success
  end

end
