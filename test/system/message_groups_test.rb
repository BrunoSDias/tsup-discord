require "application_system_test_case"

class MessageGroupsTest < ApplicationSystemTestCase
  setup do
    @message_group = message_groups(:one)
  end

  test "visiting the index" do
    visit message_groups_url
    assert_selector "h1", text: "Message groups"
  end

  test "should create message group" do
    visit message_groups_url
    click_on "New message group"

    fill_in "User chatroom", with: @message_group.user_chatroom_id
    click_on "Create Message group"

    assert_text "Message group was successfully created"
    click_on "Back"
  end

  test "should update Message group" do
    visit message_group_url(@message_group)
    click_on "Edit this message group", match: :first

    fill_in "User chatroom", with: @message_group.user_chatroom_id
    click_on "Update Message group"

    assert_text "Message group was successfully updated"
    click_on "Back"
  end

  test "should destroy Message group" do
    visit message_group_url(@message_group)
    click_on "Destroy this message group", match: :first

    assert_text "Message group was successfully destroyed"
  end
end
