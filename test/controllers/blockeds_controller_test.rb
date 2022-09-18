require "test_helper"

class BlockedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blocked = blockeds(:one)
  end

  test "should get index" do
    get blockeds_url
    assert_response :success
  end

  test "should get new" do
    get new_blocked_url
    assert_response :success
  end

  test "should create blocked" do
    assert_difference("Blocked.count") do
      post blockeds_url, params: { blocked: { sender_id: @blocked.sender_id, target_id: @blocked.target_id } }
    end

    assert_redirected_to blocked_url(Blocked.last)
  end

  test "should show blocked" do
    get blocked_url(@blocked)
    assert_response :success
  end

  test "should get edit" do
    get edit_blocked_url(@blocked)
    assert_response :success
  end

  test "should update blocked" do
    patch blocked_url(@blocked), params: { blocked: { sender_id: @blocked.sender_id, target_id: @blocked.target_id } }
    assert_redirected_to blocked_url(@blocked)
  end

  test "should destroy blocked" do
    assert_difference("Blocked.count", -1) do
      delete blocked_url(@blocked)
    end

    assert_redirected_to blockeds_url
  end
end
