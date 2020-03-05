require 'test_helper'

class Members::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get members_rooms_show_url
    assert_response :success
  end

end