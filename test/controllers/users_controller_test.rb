require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get set_status" do
    get users_set_status_url
    assert_response :success
  end
end
