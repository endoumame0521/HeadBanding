require 'test_helper'

class Members::AccessesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_accesses_index_url
    assert_response :success
  end

end
