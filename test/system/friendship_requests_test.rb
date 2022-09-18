require "application_system_test_case"

class FriendshipRequestsTest < ApplicationSystemTestCase
  setup do
    @friendship_request = friendship_requests(:one)
  end

  test "visiting the index" do
    visit friendship_requests_url
    assert_selector "h1", text: "Friendship requests"
  end

  test "should create friendship request" do
    visit friendship_requests_url
    click_on "New friendship request"

    fill_in "Email", with: @friendship_request.email
    click_on "Create Friendship request"

    assert_text "Friendship request was successfully created"
    click_on "Back"
  end

  test "should update Friendship request" do
    visit friendship_request_url(@friendship_request)
    click_on "Edit this friendship request", match: :first

    fill_in "Email", with: @friendship_request.email
    click_on "Update Friendship request"

    assert_text "Friendship request was successfully updated"
    click_on "Back"
  end

  test "should destroy Friendship request" do
    visit friendship_request_url(@friendship_request)
    click_on "Destroy this friendship request", match: :first

    assert_text "Friendship request was successfully destroyed"
  end
end
