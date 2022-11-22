require "test_helper"

class UserChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get user_chatrooms_destroy_url
    assert_response :success
  end
end
