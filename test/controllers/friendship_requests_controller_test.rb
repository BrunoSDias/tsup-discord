require "test_helper"

class FriendshipRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friendship_request = friendship_requests(:one)
  end

  test "should get index" do
    get friendship_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_friendship_request_url
    assert_response :success
  end

  test "should create friendship_request" do
    assert_difference("FriendshipRequest.count") do
      post friendship_requests_url, params: { friendship_request: { email: @friendship_request.email } }
    end

    assert_redirected_to friendship_request_url(FriendshipRequest.last)
  end

  test "should show friendship_request" do
    get friendship_request_url(@friendship_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_friendship_request_url(@friendship_request)
    assert_response :success
  end

  test "should update friendship_request" do
    patch friendship_request_url(@friendship_request), params: { friendship_request: { email: @friendship_request.email } }
    assert_redirected_to friendship_request_url(@friendship_request)
  end

  test "should destroy friendship_request" do
    assert_difference("FriendshipRequest.count", -1) do
      delete friendship_request_url(@friendship_request)
    end

    assert_redirected_to friendship_requests_url
  end
end
