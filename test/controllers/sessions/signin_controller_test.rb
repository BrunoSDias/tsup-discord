require "test_helper"

class Sessions::SigninControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_signin_new_url
    assert_response :success
  end

  test "should get create" do
    get sessions_signin_create_url
    assert_response :success
  end
end
