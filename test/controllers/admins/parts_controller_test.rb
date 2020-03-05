require 'test_helper'

class Admins::PartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_parts_index_url
    assert_response :success
  end

  test "should get edit" do
    get admins_parts_edit_url
    assert_response :success
  end

end
