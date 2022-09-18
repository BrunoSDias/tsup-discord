require "test_helper"

class Sessions::SigninsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sessions_signin = sessions_signins(:one)
  end

  test "should get index" do
    get sessions_signins_url
    assert_response :success
  end

  test "should get new" do
    get new_sessions_signin_url
    assert_response :success
  end

  test "should create sessions_signin" do
    assert_difference("Sessions::Signin.count") do
      post sessions_signins_url, params: { sessions_signin: { create: @sessions_signin.create, new: @sessions_signin.new } }
    end

    assert_redirected_to sessions_signin_url(Sessions::Signin.last)
  end

  test "should show sessions_signin" do
    get sessions_signin_url(@sessions_signin)
    assert_response :success
  end

  test "should get edit" do
    get edit_sessions_signin_url(@sessions_signin)
    assert_response :success
  end

  test "should update sessions_signin" do
    patch sessions_signin_url(@sessions_signin), params: { sessions_signin: { create: @sessions_signin.create, new: @sessions_signin.new } }
    assert_redirected_to sessions_signin_url(@sessions_signin)
  end

  test "should destroy sessions_signin" do
    assert_difference("Sessions::Signin.count", -1) do
      delete sessions_signin_url(@sessions_signin)
    end

    assert_redirected_to sessions_signins_url
  end
end
