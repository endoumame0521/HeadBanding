require 'test_helper'

class Members::AnnouncesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_announces_index_url
    assert_response :success
  end

end
