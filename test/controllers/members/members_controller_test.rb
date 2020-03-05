require 'test_helper'

class Members::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_members_index_url
    assert_response :success
  end

  test "should get show" do
    get members_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get members_members_edit_url
    assert_response :success
  end

  test "should get cancel" do
    get members_members_cancel_url
    assert_response :success
  end

end
