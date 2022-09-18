require "application_system_test_case"

class BlockedsTest < ApplicationSystemTestCase
  setup do
    @blocked = blockeds(:one)
  end

  test "visiting the index" do
    visit blockeds_url
    assert_selector "h1", text: "Blockeds"
  end

  test "should create blocked" do
    visit blockeds_url
    click_on "New blocked"

    fill_in "Sender", with: @blocked.sender_id
    fill_in "Target", with: @blocked.target_id
    click_on "Create Blocked"

    assert_text "Blocked was successfully created"
    click_on "Back"
  end

  test "should update Blocked" do
    visit blocked_url(@blocked)
    click_on "Edit this blocked", match: :first

    fill_in "Sender", with: @blocked.sender_id
    fill_in "Target", with: @blocked.target_id
    click_on "Update Blocked"

    assert_text "Blocked was successfully updated"
    click_on "Back"
  end

  test "should destroy Blocked" do
    visit blocked_url(@blocked)
    click_on "Destroy this blocked", match: :first

    assert_text "Blocked was successfully destroyed"
  end
end
