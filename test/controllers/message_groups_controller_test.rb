require "test_helper"

class MessageGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_group = message_groups(:one)
  end

  test "should get index" do
    get message_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_message_group_url
    assert_response :success
  end

  test "should create message_group" do
    assert_difference("MessageGroup.count") do
      post message_groups_url, params: { message_group: { user_chatroom_id: @message_group.user_chatroom_id } }
    end

    assert_redirected_to message_group_url(MessageGroup.last)
  end

  test "should show message_group" do
    get message_group_url(@message_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_group_url(@message_group)
    assert_response :success
  end

  test "should update message_group" do
    patch message_group_url(@message_group), params: { message_group: { user_chatroom_id: @message_group.user_chatroom_id } }
    assert_redirected_to message_group_url(@message_group)
  end

  test "should destroy message_group" do
    assert_difference("MessageGroup.count", -1) do
      delete message_group_url(@message_group)
    end

    assert_redirected_to message_groups_url
  end
end
