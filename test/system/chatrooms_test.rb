require "application_system_test_case"

class ChatroomsTest < ApplicationSystemTestCase
  setup do
    @chatroom = chatrooms(:one)
  end

  test "visiting the index" do
    visit chatrooms_url
    assert_selector "h1", text: "Chatrooms"
  end

  test "should create chatroom" do
    visit chatrooms_url
    click_on "New chatroom"

    click_on "Create Chatroom"

    assert_text "Chatroom was successfully created"
    click_on "Back"
  end

  test "should update Chatroom" do
    visit chatroom_url(@chatroom)
    click_on "Edit this chatroom", match: :first

    click_on "Update Chatroom"

    assert_text "Chatroom was successfully updated"
    click_on "Back"
  end

  test "should destroy Chatroom" do
    visit chatroom_url(@chatroom)
    click_on "Destroy this chatroom", match: :first

    assert_text "Chatroom was successfully destroyed"
  end
end
