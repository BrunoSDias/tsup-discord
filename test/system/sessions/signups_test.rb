require "application_system_test_case"

class Sessions::SignupsTest < ApplicationSystemTestCase
  setup do
    @sessions_signup = sessions_signups(:one)
  end

  test "visiting the index" do
    visit sessions_signups_url
    assert_selector "h1", text: "Signups"
  end

  test "should create signup" do
    visit sessions_signups_url
    click_on "New signup"

    fill_in "Create", with: @sessions_signup.create
    fill_in "New", with: @sessions_signup.new
    click_on "Create Signup"

    assert_text "Signup was successfully created"
    click_on "Back"
  end

  test "should update Signup" do
    visit sessions_signup_url(@sessions_signup)
    click_on "Edit this signup", match: :first

    fill_in "Create", with: @sessions_signup.create
    fill_in "New", with: @sessions_signup.new
    click_on "Update Signup"

    assert_text "Signup was successfully updated"
    click_on "Back"
  end

  test "should destroy Signup" do
    visit sessions_signup_url(@sessions_signup)
    click_on "Destroy this signup", match: :first

    assert_text "Signup was successfully destroyed"
  end
end
