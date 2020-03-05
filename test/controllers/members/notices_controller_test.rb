require 'test_helper'

class Members::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get members_notices_new_url
    assert_response :success
  end

end
