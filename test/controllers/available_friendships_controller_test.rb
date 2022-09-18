require "test_helper"

class AvailableFriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get available_friendships_index_url
    assert_response :success
  end
end
