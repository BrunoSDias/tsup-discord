require "test_helper"

class Sessions::SignupControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_signup_new_url
    assert_response :success
  end

  test "should get create" do
    get sessions_signup_create_url
    assert_response :success
  end
end
