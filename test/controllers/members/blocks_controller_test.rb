require 'test_helper'

class Members::BlocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_blocks_index_url
    assert_response :success
  end

end
