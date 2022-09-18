require "test_helper"

class Sessions::SignupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sessions_signup = sessions_signups(:one)
  end

  test "should get index" do
    get sessions_signups_url
    assert_response :success
  end

  test "should get new" do
    get new_sessions_signup_url
    assert_response :success
  end

  test "should create sessions_signup" do
    assert_difference("Sessions::Signup.count") do
      post sessions_signups_url, params: { sessions_signup: { create: @sessions_signup.create, new: @sessions_signup.new } }
    end

    assert_redirected_to sessions_signup_url(Sessions::Signup.last)
  end

  test "should show sessions_signup" do
    get sessions_signup_url(@sessions_signup)
    assert_response :success
  end

  test "should get edit" do
    get edit_sessions_signup_url(@sessions_signup)
    assert_response :success
  end

  test "should update sessions_signup" do
    patch sessions_signup_url(@sessions_signup), params: { sessions_signup: { create: @sessions_signup.create, new: @sessions_signup.new } }
    assert_redirected_to sessions_signup_url(@sessions_signup)
  end

  test "should destroy sessions_signup" do
    assert_difference("Sessions::Signup.count", -1) do
      delete sessions_signup_url(@sessions_signup)
    end

    assert_redirected_to sessions_signups_url
  end
end
