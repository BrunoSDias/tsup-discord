require "application_system_test_case"

class Sessions::SigninsTest < ApplicationSystemTestCase
  setup do
    @sessions_signin = sessions_signins(:one)
  end

  test "visiting the index" do
    visit sessions_signins_url
    assert_selector "h1", text: "Signins"
  end

  test "should create signin" do
    visit sessions_signins_url
    click_on "New signin"

    fill_in "Create", with: @sessions_signin.create
    fill_in "New", with: @sessions_signin.new
    click_on "Create Signin"

    assert_text "Signin was successfully created"
    click_on "Back"
  end

  test "should update Signin" do
    visit sessions_signin_url(@sessions_signin)
    click_on "Edit this signin", match: :first

    fill_in "Create", with: @sessions_signin.create
    fill_in "New", with: @sessions_signin.new
    click_on "Update Signin"

    assert_text "Signin was successfully updated"
    click_on "Back"
  end

  test "should destroy Signin" do
    visit sessions_signin_url(@sessions_signin)
    click_on "Destroy this signin", match: :first

    assert_text "Signin was successfully destroyed"
  end
end
